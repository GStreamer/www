import fcntl
import json
import tempfile
import unittest
import zipfile
from pathlib import Path
from unittest import mock

import freedesktop_www_importer as importer

SITE = {
    "public/index.html": "the brand new home page",
    "public/news/a.html": "news",
    "public/documentation/index.html": "must not land",
    "public/data/must-not-land.txt": "x",
    "public/media/must-not-land.txt": "x",
}
DOCS = {
    "documentation/index.html": "the brand new documentation",
    "documentation/gstreamer/new.html": "new page",
}
SERVER = {
    "index.html": "the old home page",
    "data/src/tarball.txt": "tarball",
    "media/sample.txt": "sample",
    "planet/index.html": "planet",
    "documentation/index.html": "old docs",
    "documentation/gstreamer/removed.html": "gone",
    "legacy.html": "stays",
}


def write(root: Path, files: dict[str, str]) -> None:
    for name, text in files.items():
        path = root / name
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(text)


def artifact(path: Path, files: dict[str, str]) -> None:
    with zipfile.ZipFile(path, "w") as z:
        for name, text in files.items():
            z.writestr(name, text)


def tree(root: Path) -> dict[str, str]:
    return {str(p.relative_to(root)): p.read_text() for p in root.rglob("*") if p.is_file()}


class ImporterTest(unittest.TestCase):
    def setUp(self):
        root = Path(self.enterContext(tempfile.TemporaryDirectory()))
        self.www, self.htdocs = root / "www", root / "www" / "htdocs"
        write(self.htdocs, SERVER)
        self.zips = {"website": root / "site.zip", "documentation": root / "docs.zip"}

    def run_importer(self, *extra):
        zips = [f"--zip={name}={path}" for name, path in self.zips.items() if path.exists()]
        return importer.main(["--www", str(self.www), *zips, *extra])

    def test_the_site_is_copied_and_the_directories_deployed_elsewhere_are_kept(self):
        artifact(self.zips["website"], SITE)
        self.assertEqual(self.run_importer("website"), 0)
        got = tree(self.htdocs)
        self.assertEqual(got["index.html"], "the brand new home page")
        self.assertEqual(got["news/a.html"], "news")
        # what is deployed separately is never touched, whatever the artifact has
        self.assertEqual(got["documentation/index.html"], "old docs")
        self.assertEqual(got["data/src/tarball.txt"], "tarball")
        self.assertEqual(got["media/sample.txt"], "sample")
        self.assertEqual(got["planet/index.html"], "planet")
        self.assertNotIn("data/must-not-land.txt", got)
        self.assertNotIn("media/must-not-land.txt", got)
        # nothing is deleted
        self.assertEqual(got["legacy.html"], "stays")
        self.assertEqual(got["documentation/gstreamer/removed.html"], "gone")

    def test_the_documentation_replaces_the_one_of_the_server_and_nothing_else(self):
        artifact(self.zips["documentation"], DOCS)
        self.assertEqual(self.run_importer("documentation"), 0)
        got = tree(self.htdocs)
        self.assertEqual(got["documentation/index.html"], "the brand new documentation")
        self.assertEqual(got["documentation/gstreamer/new.html"], "new page")
        self.assertNotIn("documentation/gstreamer/removed.html", got)
        self.assertEqual({k: v for k, v in got.items() if not k.startswith("documentation/")},
                         {k: v for k, v in SERVER.items() if not k.startswith("documentation/")})

    def test_both_are_updated_by_default(self):
        artifact(self.zips["website"], SITE)
        artifact(self.zips["documentation"], DOCS)
        self.assertEqual(self.run_importer(), 0)
        got = tree(self.htdocs)
        self.assertEqual(got["index.html"], "the brand new home page")
        self.assertEqual(got["documentation/index.html"], "the brand new documentation")

    def test_a_dry_run_changes_nothing(self):
        artifact(self.zips["website"], SITE)
        artifact(self.zips["documentation"], DOCS)
        self.assertEqual(self.run_importer("--dry-run"), 0)
        self.assertEqual(tree(self.htdocs), SERVER)

    def test_an_artifact_without_a_home_page_is_not_deployed_and_the_other_target_still_is(self):
        artifact(self.zips["website"], {"public/news/a.html": "no home page"})
        artifact(self.zips["documentation"], DOCS)
        self.assertEqual(self.run_importer(), 1)
        got = tree(self.htdocs)
        self.assertNotIn("news/a.html", got)
        self.assertEqual(got["index.html"], "the old home page")
        self.assertEqual(got["documentation/index.html"], "the brand new documentation")

    def test_an_empty_documentation_does_not_delete_the_one_of_the_server(self):
        artifact(self.zips["documentation"], {"documentation/other.html": "x"})
        self.assertEqual(self.run_importer("documentation"), 1)
        self.assertEqual(tree(self.htdocs), SERVER)

    def test_a_broken_archive_is_a_failure_not_a_crash(self):
        self.zips["website"].write_text("not a zip")
        self.assertEqual(self.run_importer("website"), 1)
        self.assertEqual(tree(self.htdocs), SERVER)

    def test_a_path_outside_of_the_artifact_does_not_escape(self):
        artifact(self.zips["website"], {"public/index.html": "x", "../escaped.txt": "x", "/abs/escaped.txt": "x"})
        self.run_importer("website")
        self.assertFalse((self.www.parent / "escaped.txt").exists())
        self.assertFalse(Path("/abs/escaped.txt").exists())

    def test_an_unknown_target_or_archive_is_refused(self):
        for argv in (["nothing"], ["--zip=nothing=x.zip"], ["--zip=website"]):
            with self.assertRaises(SystemExit), mock.patch("sys.stderr"):
                importer.main(["--www", str(self.www), *argv])

    def test_a_job_is_deployed_once_per_target(self):
        artifact(self.zips["website"], SITE)
        artifact(self.zips["documentation"], DOCS)
        jobs = {"gstreamer/www": 42, "gstreamer/gstreamer": 7}
        downloads = []

        def download(url, dest):
            downloads.append(url)
            dest.write_bytes(self.zips["documentation" if "gstreamer/gstreamer/" in url else "website"].read_bytes())

        latest = mock.patch.object(importer.GitLab, "latest_job", lambda self, project, ref, name: {"id": jobs[project]})
        with latest, mock.patch.object(importer, "download", download):
            argv = ["--www", str(self.www)]
            self.assertEqual(importer.main(argv), 0)
            self.assertEqual(importer.main(argv), 0)
            self.assertEqual(len(downloads), 2)
            self.assertTrue(downloads[0].endswith("/gstreamer/www/-/jobs/42/artifacts/download"))
            self.assertTrue(downloads[1].endswith("/gstreamer/gstreamer/-/jobs/7/artifacts/download"))
            self.assertEqual((self.www / ".website-job").read_text(), "42\n")
            self.assertEqual((self.www / ".documentation-job").read_text(), "7\n")
            # a new job of one target is deployed alone, and --force deploys again
            jobs["gstreamer/gstreamer"] = 8
            importer.main(argv)
            self.assertEqual(len(downloads), 3)
            importer.main([*argv, "--force"])
            self.assertEqual(len(downloads), 5)

    def test_no_job_is_a_failure_for_that_target_only(self):
        artifact(self.zips["documentation"], DOCS)
        latest = lambda self, project, ref, name: None if project == "gstreamer/www" else {"id": 1}  # noqa: E731
        download = lambda url, dest: dest.write_bytes(self.zips["documentation"].read_bytes())  # noqa: E731
        with mock.patch.object(importer.GitLab, "latest_job", latest), mock.patch.object(importer, "download", download):
            self.assertEqual(importer.main(["--www", str(self.www)]), 1)
        self.assertEqual(tree(self.htdocs)["documentation/index.html"], "the brand new documentation")

    def test_a_dry_run_does_not_record_the_job(self):
        artifact(self.zips["website"], SITE)
        download = lambda url, dest: dest.write_bytes(self.zips["website"].read_bytes())  # noqa: E731
        with mock.patch.object(importer.GitLab, "latest_job", lambda *args: {"id": 7}), mock.patch.object(
            importer, "download", download
        ):
            importer.main(["--www", str(self.www), "--dry-run", "website"])
        self.assertFalse((self.www / ".website-job").exists())

    def test_a_run_during_another_one_does_nothing(self):
        artifact(self.zips["website"], SITE)
        self.www.mkdir(exist_ok=True)
        with (self.www / ".www-importer.lock").open("w") as held:
            fcntl.flock(held, fcntl.LOCK_EX)
            self.assertEqual(self.run_importer(), 0)
        self.assertEqual(tree(self.htdocs), SERVER)


class GitLabTest(unittest.TestCase):
    def test_the_latest_job_ignores_the_status_of_the_pipeline(self):
        calls = []

        def pages(self, path, **params):
            calls.append((path, params))
            if path.endswith("/pipelines"):
                return iter([{"id": 1, "status": "canceled"}, {"id": 2, "status": "success"}])
            return iter([{"id": 10, "name": "other"}, {"id": 11, "name": "documentation"}]) if "/1/" in path else iter([])

        with mock.patch.object(importer.GitLab, "pages", pages):
            job = importer.GitLab("https://x").latest_job("gstreamer/gstreamer", "main", "documentation")
        self.assertEqual(job["id"], 11)
        self.assertEqual(
            calls,
            [
                ("projects/gstreamer%2Fgstreamer/pipelines", {"ref": "main"}),
                ("projects/gstreamer%2Fgstreamer/pipelines/1/jobs", {"scope[]": "success"}),
            ],
        )

    def test_the_query_is_encoded_and_every_page_is_read(self):
        urls = []

        def urlopen(url, timeout):
            urls.append(url)
            response = mock.MagicMock()
            response.__enter__.return_value = response
            response.read.return_value = json.dumps([len(urls)]).encode()
            response.headers = {"X-Next-Page": "2" if len(urls) == 1 else ""}
            return response

        with mock.patch.object(importer.urllib.request, "urlopen", urlopen):
            got = list(importer.GitLab("https://x").pages("projects/a%2Fb/pipelines", ref="topic/one two"))
        self.assertEqual(got, [1, 2])
        self.assertEqual(
            urls,
            [
                "https://x/api/v4/projects/a%2Fb/pipelines?per_page=100&page=1&ref=topic%2Fone+two",
                "https://x/api/v4/projects/a%2Fb/pipelines?per_page=100&page=2&ref=topic%2Fone+two",
            ],
        )


if __name__ == "__main__":
    unittest.main()
