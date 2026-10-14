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

CI (`.gitlab-ci.yml`) only validates the site: it lints the content, builds it
with Hugo and checks the internal links (`build website`, in the user's
namespace and in merge requests).

The site is deployed as before, with `bin/www-update` (it runs
`bin/www-update-complete` on the web server): `git pull`, build with Hugo into
a temporary directory and `rsync` that over the web root. The rsync never uses
`--delete` and skips `data`, `src`, `pkg`, `media`, `documentation` and
`planet`, which are deployed separately. Hugo has to be installed on the server
(see `HUGO_VERSION` in `ci/docker/prepare.sh`). To keep the activity numbers on
the home page fresh, run `bin/www-update-complete` from a daily cron job.

To update content, see [CONTRIBUTING.md](CONTRIBUTING.md).
