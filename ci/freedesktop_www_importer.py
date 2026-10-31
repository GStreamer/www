#!/usr/bin/python3
"""Update the website and the documentation on the fdo server from the artifacts of the latest CI jobs.

Run it from cron (see ci/www_cron.py). Each target is the latest successful job
of a project on its main branch, whose artifact is copied into the web root:

- website: the "website" job of gstreamer/www, whose public/ is copied over
  htdocs/ without deleting anything (the web root has more than what the site
  generates), except data/, src/, pkg/, media/, documentation/ and planet/, which
  are deployed separately and never touched,
- documentation: the "documentation" job of gstreamer/gstreamer, whose
  documentation/ replaces htdocs/documentation/ (what it does not have is deleted).

Nothing is done for a target when its job was already deployed (one stamp per
target). A target that fails does not stop the next ones. Only the standard
library and rsync are needed, and it can be tried anywhere:

  ci/freedesktop_www_importer.py --www /tmp/www --dry-run
  ci/freedesktop_www_importer.py --www /tmp/www --zip website=artifacts.zip website
"""
from __future__ import annotations

import argparse
import contextlib
import fcntl
import json
import logging
import shlex
import shutil
import subprocess
import sys
import tempfile
import urllib.parse
import urllib.request
import zipfile
from collections.abc import Iterator
from dataclasses import dataclass
from pathlib import Path

log = logging.getLogger("www")

GITLAB = "https://gitlab.freedesktop.org"
WWW = Path("/srv/gstreamer.freedesktop.org/www")
GROUP = "gstreamer"


class DeployError(Exception):
    """Something that stops a target from being deployed, with the reason."""


@dataclass(frozen=True)
class Target:
    name: str
    project: str
    job: str
    # the directory of the artifact that is deployed, and the one of htdocs it goes to
    src: str
    dest: str = ""
    # whether what the artifact does not have is deleted in `dest`, and what is never touched
    delete: bool = False
    keep: tuple[str, ...] = ()
    ref: str = "main"

    def rsync_args(self) -> list[str]:
        args = ["-rlpt", "--chmod=g+w"]
        if self.delete:
            args.append("--delete")
        return args + [f"--exclude=/{name}" for name in self.keep]


TARGETS = {
    target.name: target
    for target in (
        Target(
            "website",
            project="gstreamer/www",
            job="website",
            src="public",
            keep=("data", "src", "pkg", "media", "documentation", "planet"),
        ),
        Target(
            "documentation",
            project="gstreamer/gstreamer",
            job="documentation",
            src="documentation",
            dest="documentation",
            delete=True,
        ),
    )
}


class GitLab:
    def __init__(self, base: str = GITLAB):
        self.base = base

    def get(self, path: str, **params) -> tuple[object, str | None]:
        """The JSON of a request, and the number of the next page if there is one."""
        url = f"{self.base}/api/v4/{path}?{urllib.parse.urlencode(params)}"
        with urllib.request.urlopen(url, timeout=60) as response:
            return json.load(response), response.headers.get("X-Next-Page")

    def pages(self, path: str, **params) -> Iterator[dict]:
        page: str | None = "1"
        while page:
            items, page = self.get(path, per_page=100, page=page, **params)
            yield from items

    def latest_job(self, project: str, ref: str, name: str) -> dict | None:
        """The latest successful job called `name` on `ref`, or None.

        The status of the pipeline does not matter: a pipeline that was canceled
        after the job, or that waits for a manual job, still has its artifact.
        """
        pid = urllib.parse.quote(project, safe="")
        for n, pipeline in enumerate(self.pages(f"projects/{pid}/pipelines", ref=ref)):
            if n >= 100:
                break
            for job in self.pages(f"projects/{pid}/pipelines/{pipeline['id']}/jobs", **{"scope[]": "success"}):
                if job["name"] == name:
                    return job
        return None

    def artifact_url(self, project: str, job_id: str) -> str:
        return f"{self.base}/{project}/-/jobs/{job_id}/artifacts/download"


def download(url: str, dest: Path) -> None:
    with urllib.request.urlopen(url, timeout=600) as response, dest.open("wb") as f:
        shutil.copyfileobj(response, f)


def rsync(args: list[str], src: Path, dest: Path, dry_run: bool) -> None:
    cmd = ["rsync", *args, *(["--dry-run"] if dry_run else []), f"{src}/", f"{dest}/"]
    log.info("+ %s", shlex.join(cmd))
    subprocess.run(cmd, check=True)


def share_with_group(root: Path) -> None:
    """Give the files of the web root to the group of the project, as far as we are allowed to."""
    for path in (root, *root.rglob("*")):
        with contextlib.suppress(LookupError, PermissionError):
            shutil.chown(path, group=GROUP)


def deploy(target: Target, tree: Path, htdocs: Path, dry_run: bool) -> None:
    """Copy the directory of the artifact that `target` says into htdocs."""
    src = tree / target.src
    if not (src / "index.html").is_file():
        raise DeployError(f"No {target.src}/index.html in the artifact, not deploying {target.name}")
    dest = htdocs / target.dest
    dest.mkdir(parents=True, exist_ok=True)
    rsync(target.rsync_args(), src, dest, dry_run)
    if not dry_run:
        share_with_group(dest)


def update(target: Target, args: argparse.Namespace, gitlab: GitLab, tmp: Path) -> None:
    """Deploy one target, unless its latest job is the one that was deployed."""
    stamp = args.www / f".{target.name}-job"
    job_id = None
    if archive := args.local.get(target.name):
        log.info("Updating %s from %s", target.name, archive)
    else:
        job = gitlab.latest_job(target.project, target.ref, target.job)
        if job is None:
            raise DeployError(f"No successful {target.job} job found on {target.ref} of {target.project}")
        job_id = str(job["id"])
        if not args.force and stamp.is_file() and stamp.read_text().strip() == job_id:
            log.info("Job %s already deployed, nothing to do", job_id)
            return
        url = gitlab.artifact_url(target.project, job_id)
        log.info("Updating %s from %s", target.name, url)
        archive = tmp / f"{target.name}.zip"
        download(url, archive)
    # extractall() leaves out the absolute and the ".." parts of the names
    tree = tmp / target.name
    with zipfile.ZipFile(archive) as z:
        z.extractall(tree)
    deploy(target, tree, args.htdocs, args.dry_run)
    if job_id and not args.dry_run:
        stamp.write_text(f"{job_id}\n")
    log.info("Done updating %s%s", target.name, " (dry run)" if args.dry_run else "")


@contextlib.contextmanager
def exclusive(lock_file: Path) -> Iterator[bool]:
    """Whether this is the only run, which stays so until the end of the block."""
    with lock_file.open("w") as f:
        try:
            fcntl.flock(f, fcntl.LOCK_EX | fcntl.LOCK_NB)
        except BlockingIOError:
            yield False
        else:
            yield True


def target_name(value: str) -> str:
    if value not in TARGETS:
        raise argparse.ArgumentTypeError(f"unknown target {value}, use {', '.join(TARGETS)}")
    return value


def local_archive(value: str) -> tuple[str, Path]:
    name, _, path = value.partition("=")
    if not path:
        raise argparse.ArgumentTypeError("wants TARGET=FILE")
    return target_name(name), Path(path).resolve()


def parse_args(argv: list[str] | None) -> argparse.Namespace:
    p = argparse.ArgumentParser(description=__doc__.split("\n\n")[0])
    p.add_argument(
        "targets",
        nargs="*",
        type=target_name,
        metavar="target",
        help=f"what to update, default all of: {', '.join(TARGETS)}",
    )
    p.add_argument("--www", type=Path, default=WWW, help=f"directory with htdocs/ and the stamps (default {WWW})")
    p.add_argument("--htdocs", type=Path, help="web root to deploy into (default: htdocs/ of --www)")
    p.add_argument("--gitlab", default=GITLAB)
    p.add_argument(
        "--zip",
        type=local_archive,
        action="append",
        default=[],
        metavar="TARGET=FILE",
        help="deploy this artifact for a target instead of the one of its latest job (no stamp)",
    )
    p.add_argument("--force", action="store_true", help="deploy even if the job was already deployed")
    p.add_argument("--dry-run", action="store_true", help="show what would change, change nothing")
    args = p.parse_args(argv)
    args.local = dict(args.zip)
    args.htdocs = args.htdocs or args.www / "htdocs"
    return args


def main(argv: list[str] | None = None) -> int:
    args = parse_args(argv)
    logging.basicConfig(level=logging.INFO, format="%(message)s")
    gitlab = GitLab(args.gitlab)
    args.www.mkdir(parents=True, exist_ok=True)

    failed = False
    with exclusive(args.www / ".www-importer.lock") as alone:
        if not alone:
            log.info("Another run is going on, nothing to do")
            return 0
        for name in args.targets or TARGETS:
            log.info("=== %s", name)
            with tempfile.TemporaryDirectory() as tmp:
                try:
                    update(TARGETS[name], args, gitlab, Path(tmp))
                except (DeployError, OSError, subprocess.CalledProcessError, zipfile.BadZipFile) as e:
                    # one target must not stop the others
                    log.error("!!! %s failed: %s", name, e)
                    failed = True
    return int(failed)


if __name__ == "__main__":
    sys.exit(main())
