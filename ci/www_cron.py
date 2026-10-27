#!/usr/bin/python3
"""Update everything the web server gets from the CI, from one cron job.

It is run regularly, every few hours like the planet is built, and does three things:

- site: the website and the documentation, each one when a new CI job built it
  (ci/freedesktop_www_importer.py),
- planet: the latest build of the planet (planet/planet-rs-download-latest.py),
- activity: htdocs/activity.json, which the home page reads (tools/fetch-activity.py).

A step that fails does not stop the next ones, the exit status says if one did.
Nothing is changed with --dry-run, and --www can point to another directory to
try it anywhere.
"""
from __future__ import annotations

import argparse
import logging
import os
import shlex
import shutil
import subprocess
import sys
import tempfile
import time
from collections.abc import Callable
from pathlib import Path

import freedesktop_www_importer as importer

log = logging.getLogger("www")

ROOT = Path(__file__).resolve().parent.parent


def run(cmd: list[str]) -> int:
    log.info("+ %s", shlex.join(cmd))
    return subprocess.run(cmd).returncode


def site(www: Path, dry_run: bool) -> int:
    return importer.main(["--www", str(www), *(["--dry-run"] if dry_run else [])])


def planet(www: Path, dry_run: bool) -> int:
    deploy = www / "htdocs" / "planet"
    if not dry_run:
        deploy.mkdir(parents=True, exist_ok=True)
    cmd = [sys.executable, str(ROOT / "planet" / "planet-rs-download-latest.py"), "--deploy-dir", f"{deploy}/"]
    return run(cmd + (["--dry-run"] if dry_run else []))


def activity(www: Path, dry_run: bool) -> int:
    """fetch-activity.py keeps the previous value of a field it cannot get."""
    fetch = [sys.executable, str(ROOT / "tools" / "fetch-activity.py"), "--out"]
    out = www / "htdocs" / "activity.json"
    if dry_run:
        with tempfile.TemporaryDirectory() as tmp:
            copy = Path(tmp) / out.name
            if out.is_file():
                shutil.copyfile(out, copy)
            return run([*fetch, str(copy)])
    out.parent.mkdir(parents=True, exist_ok=True)
    return run([*fetch, str(out)])


STEPS: list[tuple[str, Callable[[Path, bool], int]]] = [("site", site), ("planet", planet), ("activity", activity)]


def main(argv: list[str] | None = None) -> int:
    p = argparse.ArgumentParser(description=__doc__.split("\n\n")[0])
    p.add_argument(
        "--www",
        type=Path,
        default=importer.WWW,
        help="directory with htdocs/ and the stamps",
    )
    p.add_argument("--dry-run", action="store_true", help="show what would change, change nothing")
    args = p.parse_args(argv)
    logging.basicConfig(level=logging.INFO, format="%(message)s")
    os.umask(0o002)
    args.www.mkdir(parents=True, exist_ok=True)

    failed = False
    with importer.exclusive(args.www / ".www-cron.lock") as alone:
        if not alone:
            log.info("Another run is going on, nothing to do")
            return 0
        for name, step in STEPS:
            log.info("=== %s (%s)", name, time.strftime("%F %T"))
            try:
                status = step(args.www, args.dry_run)
            except (importer.DeployError, OSError) as e:  # one step must not stop the others
                log.error("%s: %s", name, e)
                status = 1
            if status:
                log.error("!!! %s failed (%s)", name, status)
                failed = True
    return int(failed)


if __name__ == "__main__":
    sys.exit(main())
