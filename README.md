# GStreamer website

Source of https://gstreamer.freedesktop.org/, built with [Hugo](https://gohugo.io/)
(extended edition, version pinned in `ci/docker/prepare.sh`).

Layout:

- `content/`   Markdown pages with front matter (news, releases, security, conference, modules, ...)
- `layouts/`   Hugo templates and partials
- `assets/`    CSS and other processed assets
- `site-data/` `nav.yml`, `release.yml`, `activity.json` (statistics, refreshed by `tools/fetch-activity.py`), conference schedules
- `src/`       images, documents and Apache config of the legacy site, mounted into the build by `hugo.toml`
- `archetypes/` templates for `hugo new`
- `tools/`     `fetch-activity.py`, `lint-content.py`, `check-links.py`, `new-release.py`
- `planet/`    script used by the Planet cron job on the server

## Local preview

```sh
hugo server          # http://localhost:1313/, rebuilds on every save
hugo --destination public   # one-off build
sh tools/post-build.sh public   # installs the .htaccess files
```

URLs are "ugly" (`/security/sa-2024-0001.html`) so that all legacy URLs keep working.

## Checks

```sh
python3 tools/lint-content.py                 # front matter of every content file
hugo --destination public
python3 tools/check-links.py --public public  # broken internal links and anchors
python3 tools/fetch-activity.py               # refresh site-data/activity.json (optional, offline safe)
```

## Deploy

CI (`.gitlab-ci.yml`) lints the content, builds the site with Hugo and checks
the internal links (`build website`, in the user's namespace and in merge
requests).

In the gstreamer namespace, the `website` job builds the site on the main
branch, after each merge and from a daily scheduled pipeline (which also
refreshes the activity numbers on the home page), and keeps it as an artifact.
On the web server, `ci/freedesktop_www_importer.py` deploys the latest
successful `website` job into `htdocs/`, like gstreamer's
`ci/gitlab/freedesktop_doc_importer.py` does for the documentation. Run it
from cron; it does nothing when that job was already deployed.
`bin/www-update` runs it by hand. The rsync never uses `--delete` and skips
`data`, `src`, `pkg`, `media`, `documentation` and `planet`, which are deployed
separately. Hugo does not need to be installed on the server.

To update content, see [CONTRIBUTING.md](CONTRIBUTING.md).
