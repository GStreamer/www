#!/usr/bin/env python3
#
# planet-rs-download-latest.py
#
# This script is run from a cron job on annarchy (aka gstreamer.freedesktop.org)
# to download and deploy the latest planet-rs build into the web server's
# planet directory, until we move to a different web server where we can
# deploy things directly more easily.
# -----------------------------------------------------------------------------------
# Copyright (C) 2025 Tim-Philipp Müller <tim centricular com>
#
# This Source Code Form is subject to the terms of the Mozilla Public License, v2.0.
# If a copy of the MPL was not distributed with this file, You can obtain one at
# <https://mozilla.org/MPL/2.0/>.
#
# SPDX-License-Identifier: MPL-2.0
# -----------------------------------------------------------------------------------
# docs: https://python-gitlab.readthedocs.io/en/stable/api-objects.html
# -----------------------------------------------------------------------------------
# autopep8 --in-place --max-line-len=139 planet-rs-download-latest.py

import argparse
import os
import sys
import datetime
import shutil
import subprocess
import tempfile
import urllib.request
import zipfile
import gitlab

PROJECT_PATH = 'vjaquez/planet-rs'

# Scheduled pipeline runs every 3 hours
SCHEDULE_INTERVAL_HOURS = 3

DOWNLOAD_DIR = os.path.join(tempfile.gettempdir(), 'gstreamer-planet-rs-downloads/')


parser = argparse.ArgumentParser(description='''
    Download latest GStreamer planet build artefacts, unzip them and deploy
    them to a target directory.
    ''')

parser.add_argument('--deploy-dir', type=str, default=None, required=True,
                    help='Directory into which to deploy the planet page and assets')

parser.add_argument('--dry-run', action='store_true',
                    help='Don\'t actually deploy into target directory, just simulate deployment')


parser.add_argument('--verbose', action='store_true',
                    help='More verbose output')

args = parser.parse_args()

# gl = gitlab.Gitlab.from_config('fdo', [os.path.expanduser('~/.python-gitlab.cfg')])

# Anonymous access should be sufficient
gl = gitlab.Gitlab('https://gitlab.freedesktop.org')

project = gl.projects.get(PROJECT_PATH)
if not project:
    sys.exit(f'ERROR: Failed to get project {PROJECT_PATH}!')

since = datetime.datetime.now(datetime.timezone.utc) - datetime.timedelta(hours=SCHEDULE_INTERVAL_HOURS)
since_dmyt = since.strftime('%Y-%m-%dT%H:%MZ')

# can filter by updated_after, status (failed/canceled)
pipelines = project.pipelines.list(updated_after=since_dmyt, source='schedule', ref='main')
if not pipelines:
    sys.exit(f'ERROR: could not find any recent scheduled pipelines in {PROJECT_PATH}!')

if len(pipelines) > 1:
    print('WARNING: found more than one recent scheduled pipeline! Taking latest')

pipeline = pipelines[0]

# if args.verbose:
#    print('Pipeline:', pipeline)

# Pipeline creation time without the seconds and microseconds
pipeline_date = pipeline.created_at[:16] + 'Z'
print('Last scheduled pipeline was at', pipeline_date)

workdir = os.path.join(DOWNLOAD_DIR, f'{pipeline_date}')
os.makedirs(workdir, exist_ok=True)
os.chdir(workdir)
print('Working in', workdir)

jobs = pipeline.jobs.list()

build_job = [job for job in jobs if job.name == 'build'][0]

if build_job.status != 'success':
    sys.exit(f'Error: Build job status is {build_job.status}: {build_job.web_url}')

# if args.verbose:
#    print('Build job:', build_job)

archives = list(filter(lambda artifact: artifact['file_type'] == 'archive' and artifact['file_format'] == 'zip', build_job.artifacts))
assert len(archives) == 1
archive_size = archives[0]['size']

url = f'https://gitlab.freedesktop.org/{PROJECT_PATH}/-/jobs/{build_job.id}/artifacts/download'
zip_fn = f'{build_job.id}-artifacts.zip'

do_download = True

if os.path.isfile(zip_fn):
    zip_size = os.path.getsize(zip_fn)
    if zip_size == archive_size:
        print(f'Job artifact {zip_fn} with size {archive_size} exists already, not downloading.')
        do_download = False
    else:
        print(f'Job artifact {zip_fn} has size {zip_size} instead of {archive_size}, deleting and re-downloading!')
        os.remove(zip_fn)

if do_download:
    print(f'Downloading {url}..')

    with urllib.request.urlopen(url) as response:
        with tempfile.NamedTemporaryFile(delete=False, dir=workdir, prefix=f'{zip_fn}.') as tmp_file:
            shutil.copyfileobj(response, tmp_file)

    os.rename(tmp_file.name, zip_fn)
    zip_size = os.path.getsize(zip_fn)
    print(f'Download finished, {zip_fn}, {zip_size} bytes')
    if zip_size != archive_size:
        os.remove(zip_fn)
        sys.exit(f'ERROR: Job artifact {zip_fn} has size {zip_size} instead of {archive_size}!')

# Extract zip

with zipfile.ZipFile(zip_fn) as zf:
    files_to_extract = zf.namelist()

    staging_dir = workdir

    for file in files_to_extract:
        if args.verbose:
            print(f'Extracting {file} from {zip_fn} into {staging_dir} ...')
        zf.extract(file, path=staging_dir)

    print('Extraction finished.')

print()

print(f'Deploying to {args.deploy_dir} ...')

rsync_cmds = [
    'rsync',
    '--recursive',
    '--delete',
    os.path.join(workdir, 'output') + '/',
    args.deploy_dir,
]

if args.verbose:
    rsync_cmds.insert(1, '--verbose')

if args.dry_run:
    rsync_cmds.insert(1, '--dry-run')

if args.verbose:
    print('Running', ' '.join(rsync_cmds))

output = subprocess.check_output(rsync_cmds).decode('utf-8')

print(output)

print()

print(f'Removing "{workdir}"')
shutil.rmtree(workdir)

print()

print('All done!')
