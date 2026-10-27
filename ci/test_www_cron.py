import fcntl
import tempfile
import unittest
from pathlib import Path
from unittest import mock

import www_cron as cron


class CronTest(unittest.TestCase):
    def setUp(self):
        root = Path(self.enterContext(tempfile.TemporaryDirectory()))
        self.www, self.repo = root / "www", root / "repo"
        self.repo.mkdir()
        self.enterContext(mock.patch.object(cron, "ROOT", self.repo))
        self.commands: list[list[str]] = []
        self.status = 0

    def run_cron(self, *extra, site=0, status=0):
        def run(cmd):
            self.commands.append(cmd)
            return status

        with mock.patch.object(cron.importer, "main", return_value=site) as importer_main, mock.patch.object(
            cron, "run", run
        ):
            code = cron.main(["--www", str(self.www), *extra])
        return code, importer_main

    def test_the_three_steps_run_in_order(self):
        code, site = self.run_cron()
        self.assertEqual(code, 0)
        site.assert_called_once_with(["--www", str(self.www)])
        planet, activity = self.commands
        self.assertTrue(planet[1].endswith("planet/planet-rs-download-latest.py"))
        self.assertEqual(planet[2:], ["--deploy-dir", f"{self.www / 'htdocs' / 'planet'}/"])
        self.assertTrue(activity[1].endswith("tools/fetch-activity.py"))
        self.assertEqual(activity[2:], ["--out", str(self.www / "htdocs" / "activity.json")])

    def test_the_activity_already_there_is_kept_as_the_base(self):
        out = self.www / "htdocs" / "activity.json"
        out.parent.mkdir(parents=True)
        out.write_text("previous")
        self.run_cron()
        self.assertEqual(out.read_text(), "previous")

    def test_a_failing_step_does_not_stop_the_next_ones(self):
        code, _ = self.run_cron(site=1)
        self.assertEqual(code, 1)
        self.assertEqual(len(self.commands), 2)

    def test_a_step_that_raises_does_not_stop_the_next_ones(self):
        with mock.patch.object(cron.importer, "main", side_effect=OSError("network")), mock.patch.object(
            cron, "run", lambda cmd: self.commands.append(cmd) or 0
        ):
            self.assertEqual(cron.main(["--www", str(self.www)]), 1)
        self.assertEqual(len(self.commands), 2)

    def test_the_exit_status_says_if_a_later_step_failed(self):
        code, _ = self.run_cron(status=2)
        self.assertEqual(code, 1)
        self.assertEqual(len(self.commands), 2)

    def test_a_dry_run_is_passed_on_and_creates_nothing_in_htdocs(self):
        code, site = self.run_cron("--dry-run")
        self.assertEqual(code, 0)
        site.assert_called_once_with(["--www", str(self.www), "--dry-run"])
        planet, activity = self.commands
        self.assertIn("--dry-run", planet)
        # fetch-activity.py writes to a copy, not to htdocs
        self.assertNotEqual(Path(activity[3]), self.www / "htdocs" / "activity.json")
        self.assertFalse((self.www / "htdocs").exists())

    def test_a_run_during_another_one_does_nothing(self):
        self.www.mkdir()
        with (self.www / ".www-cron.lock").open("w") as held:
            fcntl.flock(held, fcntl.LOCK_EX)
            code, site = self.run_cron()
        self.assertEqual(code, 0)
        site.assert_not_called()
        self.assertEqual(self.commands, [])


if __name__ == "__main__":
    unittest.main()
