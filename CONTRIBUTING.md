# Contributing to the website

Updating the site never needs code changes: add (or edit) one Markdown file
with the right front matter, run `hugo server` to preview, and open a merge
request. CI runs `tools/lint-content.py` and `tools/check-links.py`, which
report missing front matter keys and broken links.

Scaffold a file with an archetype, or copy an existing one:

```sh
hugo new --kind news news/2026-10-gstreamer-1.28.8.md
```

Dates are `YYYY-MM-DD`. Content is plain Markdown; raw HTML is allowed.

## News item

File: `content/news/<slug>.md`

```yaml
---
title: "GStreamer 1.28.8 stable bugfix release"
date: 2026-10-08
---
Text of the announcement.
```

It shows up on the home page, in `/news/` and in the RSS 1.0 feed
(`/news/rss-1.0.xml`, format and item links are kept stable). Add
`homepage: false` to keep an item off the home page.

## Release

One page per release series: `content/releases/<X.Y>/_index.md`
(URL `/releases/X.Y/`, anchors `#X.Y.Z` per point release).

```yaml
---
title: "GStreamer 1.28 release notes"
series: "1.28"
status: stable        # stable, development or old stable
date: 2026-10-08
---
```

For a new point release, add a section with the heading `X.Y.Z` to the
existing series page and, if the series page lists versions in front matter,
add the entry there. Start a new series with `hugo new --kind releases releases/1.30/_index.md`.

## Security advisory

File: `content/security/sa-YYYY-NNNN.md`

```yaml
---
title: "Security Advisory 2026-0093"
id: "GStreamer-SA-2026-0093"
date: 2026-10-20
---
```

Follow an existing advisory for the remaining fields (summary, modules,
affected and fixed versions, CVE, patches) and the body text.

## Conference year

File: `content/conference/<year>/_index.md`

```yaml
---
year: 2027
status: upcoming      # upcoming or past
---
```

Subpages (schedule, speakers) are further `.md` files in the same directory.
Images and PDFs go next to the page (page bundle) or in `src/copy/images` / `src/copy/documents` (served at `/images` and `/documents`).

## Module or binding

Files: `content/modules/<name>.md`, `content/bindings/<name>.md`

```yaml
---
title: "gst-foo"
status: active        # active, legacy, ...
---
```

Legacy modules and bindings belong on the Legacy page; copy the text of an
existing entry.

## Site statistics

`tools/fetch-activity.py` writes `build/activity.json` (run by CI
before the build on main and on schedule). It uses the public GitLab API, needs no
token and keeps the previous values if the API is unreachable or rate limited.
Hugo renders it into the home page and publishes it as `/activity.json`.
The cron job of the server (`bin/www-cron`) runs the same script every few hours
into `htdocs/activity.json`, and on the home page `assets/js/activity.js`
refreshes the numbers and the recent commits from that file, so the visitors
never query GitLab.
To show the latest commits somewhere in a layout, use
`{{ partial "recent-commits.html" . }}`.

## Not deployed from this repository

`data/`, `pkg/`, `media/`, `src/`, `documentation/` and `planet/` on the server
are managed out of band and are never removed by the deploy.
