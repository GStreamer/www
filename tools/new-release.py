#!/usr/bin/env python3
"""Scaffold a new GStreamer release on the website (stdlib only).

Replaces bin/new-release (release xml + contributors) and bin/update-contributors.

  tools/new-release.py 1.28.9 [--date 2026-11-05] [--name "..."] \
      [--repo ~/devel/gstreamer/gstreamer] [--prev-tag 1.28.8] [--dry-run]

What it does:
  * adds the version to the frontmatter of content/releases/X.Y/_index.md
    (versions[], date, last_release; creates the series page for a new X.Y.0)
  * appends a notes skeleton (with the <a id="X.Y.Z"> anchor) to the series page
  * writes content/news/<date>-<HHMM>-gstreamer-X.Y.Z-<kind>.md for the news feed
  * with --repo: computes contributors (git shortlog) between --prev-tag (default:
    the previous version of the series, or X.Y.Z-1 style guess) and the tag X.Y.Z
    (or HEAD if the tag does not exist yet) and fills the "Contributors" section
Even minor version = stable, odd = development snapshot.
  * updates, like the old manual process did, the "latest bug-fix release ... is [X](#X)"
    line and the "Last updated" line at the top of the series page
  * updates site-data/release.yml (the old entities.gst): stable/branch for an even
    series, devel/devel_branch for an odd one.  The binary installer versions (bin:)
    are left alone, they follow once the binaries are published.
The home page and the releases index derive the latest versions from the series frontmatter.
"""
import argparse
import datetime
import os
import re
import subprocess
import sys

ROOT = os.path.normpath(os.path.join(os.path.dirname(os.path.abspath(__file__)), ".."))
CONTENT = os.path.join(ROOT, "content")
ORD = ["zeroth", "first", "second", "third", "fourth", "fifth", "sixth", "seventh", "eighth",
       "ninth", "tenth", "eleventh", "twelfth", "thirteenth", "fourteenth", "fifteenth"]


def vkey(v):
    return tuple(int(x) for x in v.split("."))


def contributors(repo, prev, tag):
    """Names of everybody with commits in prev..tag, sorted, like update-contributors did."""
    rng = "%s..%s" % (prev, tag)
    try:
        out = subprocess.run(["git", "-C", repo, "shortlog", "-s", "-n", "--no-merges", rng],
                             check=True, capture_output=True, text=True).stdout
    except subprocess.CalledProcessError as e:
        sys.exit("git shortlog %s failed: %s" % (rng, e.stderr.strip()))
    names = set()
    for line in out.splitlines():
        m = re.match(r"\s*\d+\s+(.*\S)\s*$", line)
        if m:
            names.add(m.group(1))
    return sorted(names, key=lambda s: s.lower())


def wrap_names(names, width=78):
    lines, cur = [], ""
    for n in names:
        piece = n + ","
        if cur and len(cur) + 1 + len(piece) > width:
            lines.append(cur)
            cur = piece
        else:
            cur = (cur + " " + piece) if cur else piece
    if cur:
        lines.append(cur)
    return "\n".join(lines)


def human(d):
    return "%02d %s %d" % (d.day, d.strftime("%B"), d.year)


def skeleton(version, series, date, stable, contrib_text):
    major, minor, micro = vkey(version)
    if stable:
        if micro == 0:
            intro = "GStreamer %s was released on %s." % (version, human(date))
        else:
            n = ORD[micro] if micro < len(ORD) else "%dth" % micro
            intro = "The %s %s bug-fix release (%s) was released on %s.\n\n" \
                    "This release only contains bugfixes and important [security fixes][security].\n" \
                    "It *should* be safe to update from %s.x and we recommend you do so at your\n" \
                    "earliest convenience.\n\n" \
                    "[security]: https://gstreamer.freedesktop.org/security/" % (
                        n, series, version, human(date), series)
    else:
        intro = "The API/ABI-unstable %s.x development snapshot release (%s) was released on %s." % (
            series, version, human(date))
    return """
<a id="{v}"></a>

### {v}

{intro}

#### Highlighted bugfixes in {v}

 - FIXME

#### Contributors to {v}

{contrib}

... and many others who have contributed bug reports, translations, sent
suggestions or helped testing. Thank you all!

#### List of merge requests and issues fixed in {v}

- [List of Merge Requests applied in {v}](https://gitlab.freedesktop.org/groups/gstreamer/-/merge_requests?scope=all&utf8=%E2%9C%93&state=merged&milestone_title={v})
- [List of Issues fixed in {v}](https://gitlab.freedesktop.org/groups/gstreamer/-/work_items?scope=all&utf8=%E2%9C%93&state=closed&milestone_title={v})
""".format(v=version, intro=intro, contrib=contrib_text or "FIXME")


def update_frontmatter(text, version, date):
    """Insert the version at the top of versions[] and refresh date/last_release."""
    m = re.match(r"^---\n(.*?)\n---\n", text, re.S)
    if not m:
        sys.exit("series page has no frontmatter")
    fm = m.group(1)
    if re.search(r'version:\s*"%s"' % re.escape(version), fm):
        sys.exit("%s is already listed in the series frontmatter" % version)
    iso = date.isoformat()
    entry = '  - version: "%s"\n    date: %s' % (version, iso)
    fm = re.sub(r"^versions:\n", "versions:\n" + entry + "\n", fm, count=1, flags=re.M)
    fm = re.sub(r"^date: .*$", "date: " + iso, fm, flags=re.M)
    fm = re.sub(r"^last_release: .*$", "last_release: " + iso, fm, flags=re.M)
    return "---\n" + fm + "\n---\n" + text[m.end():]


def refresh_header(text, version, date, stable, hhmm):
    """Update the 'latest release' sentence and the 'Last updated' line of a series page."""
    d = human(date)
    if stable:
        text = re.sub(r"^(The latest bug-fix release in the stable [\d.]+ series is )\[[\d.]+\]\(#[\d.]+\)( and was released on ).*$",
                      lambda m: "%s[%s](#%s)%s%s." % (m.group(1), version, version, m.group(2), d), text, count=1, flags=re.M)
    else:
        text = re.sub(r"^(The latest unstable development snapshot in the [\d.]+ series is )\[[\d.]+\]\(#[\d.]+\)( and was released on ).*$",
                      lambda m: "%s[%s](#%s)%s%s." % (m.group(1), version, version, m.group(2), d), text, count=1, flags=re.M)
    return re.sub(r"^\*Last updated: .*?( \[\(log\)\]\[gitlog\]\*)$",
                  lambda m: "*Last updated: %s %s, %s UTC%s" % (date.strftime("%A"), d, hhmm, m.group(1)),
                  text, count=1, flags=re.M)


def update_release_yml(version, series, stable):
    """site-data/release.yml replaces entities.gst: bump the stable or devel source release."""
    path = os.path.join(ROOT, "site-data", "release.yml")
    text = open(path, encoding="utf-8").read()
    key, bkey = ("stable", "branch") if stable else ("devel", "devel_branch")
    cur = re.search(r'^%s: "([\d.]+)"' % key, text, re.M)
    if cur and vkey(cur.group(1)) > vkey(version):
        print("site-data/release.yml: %s is already %s, left alone" % (key, cur.group(1)))
        return None
    text = re.sub(r'^%s: ".*"$' % key, '%s: "%s"' % (key, version), text, flags=re.M)
    text = re.sub(r'^%s: ".*"$' % bkey, '%s: "%s"' % (bkey, series), text, flags=re.M)
    return path, text


def new_series_page(series, version, date, stable):
    minor = vkey(series)[1]
    title = "GStreamer %s release notes" % series if stable else "GStreamer %s.x release notes" % series
    status = "stable" if stable else "devel"
    intro = ("GStreamer %s was originally released on %s." % (version, human(date)) if stable else
             "GStreamer %s.x is an API/ABI-unstable development series leading up to the stable %d.%d series." % (
                 series, vkey(series)[0], minor + 1))
    iso = date.isoformat()
    return """---
title: "{title}"
series: "{series}"
status: {status}
weight: {w}
date: {iso}
first_release: {iso}
last_release: {iso}
versions:
  - version: "{v}"
    date: {iso}
---

{intro}

<a id="introduction"></a>
## Introduction

FIXME
""".format(title=title, series=series, status=status, w=1000 - minor, iso=iso, v=version, intro=intro)


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("version", help="e.g. 1.28.9 or 1.29.3")
    ap.add_argument("--date", help="release date YYYY-MM-DD (default: today)")
    ap.add_argument("--time", default="18:00", help="news item time, UTC (default 18:00)")
    ap.add_argument("--name", help="optional release name (for the news title)")
    ap.add_argument("--repo", help="path to a gstreamer monorepo checkout (for contributors)")
    ap.add_argument("--prev-tag", help="previous release tag (default: previous version in the series page)")
    ap.add_argument("--tag", help="release tag (default: the version, or HEAD if it does not exist)")
    ap.add_argument("--dry-run", action="store_true")
    a = ap.parse_args()

    if not re.match(r"^\d+\.\d+\.\d+$", a.version):
        sys.exit("version must look like X.Y.Z")
    major, minor, micro = vkey(a.version)
    series = "%d.%d" % (major, minor)
    stable = minor % 2 == 0
    date = datetime.date.fromisoformat(a.date) if a.date else datetime.date.today()

    sdir = os.path.join(CONTENT, "releases", series)
    spage = os.path.join(sdir, "_index.md")
    writes = {}
    prev = a.prev_tag
    if os.path.exists(spage):
        text = open(spage, encoding="utf-8").read()
        olds = re.findall(r'^  - version: "([\d.]+)"', text, re.M)
        if not prev and olds:
            prev = max(olds, key=vkey)
    else:
        text = None

    contrib = None
    if a.repo:
        if not prev:
            sys.exit("--prev-tag is required (no previous version found in the series)")
        tag = a.tag
        if not tag:
            ok = subprocess.run(["git", "-C", a.repo, "rev-parse", "-q", "--verify", "refs/tags/" + a.version],
                                capture_output=True).returncode == 0
            tag = a.version if ok else "HEAD"
        names = contributors(a.repo, prev, tag)
        print("%d contributors in %s..%s" % (len(names), prev, tag))
        contrib = wrap_names(names)

    body = skeleton(a.version, series, date, stable, contrib)
    if text is None:
        writes[spage] = new_series_page(series, a.version, date, stable) + body
        print("creating new series page %s" % spage)
    else:
        newtext = update_frontmatter(text, a.version, date)
        newtext = refresh_header(newtext, a.version, date, stable, a.time)
        if not newtext.endswith("\n"):
            newtext += "\n"
        writes[spage] = newtext + body

    yml = update_release_yml(a.version, series, stable)
    if yml:
        writes[yml[0]] = yml[1]

    kind = ("stable-bug-fix-release" if micro else "stable-feature-release") if stable else "development-snapshot"
    slug = "gstreamer-%s-%s" % (a.version, kind)
    hhmm = a.time.replace(":", "")
    news = os.path.join(CONTENT, "news", "%s-%s-%s.md" % (date.isoformat(), hhmm, slug))
    if stable:
        what = ("%s stable feature release" % a.version) if not micro else "%s stable bug fix release" % a.version
        para = ("The GStreamer team is pleased to announce another bug fix release\n"
                "in the stable %s release series of your favourite cross-platform\n"
                "multimedia framework!\n\n"
                "This release only contains bug fixes as well as a number of\n"
                '<a href="/security/">security fixes</a>. It should be safe to update\n'
                "from %s.x, and we recommend you do so at your earliest convenience."
                % (series, series)) if micro else (
                "The GStreamer team is proud to announce a new major feature release\n"
                "in the stable 1.x API series of your favourite cross-platform multimedia framework!")
    else:
        what = "%s development snapshot release" % a.version
        para = ("The GStreamer team is pleased to announce the %s development snapshot\n"
                "release, an API/ABI-unstable preview of the upcoming stable release series." % a.version)
    title = "GStreamer %s%s" % (what, ' "%s"' % a.name if a.name else "")
    writes[news] = """---
title: "{title}"
date: {date} {time}
tags: [release]
version: "{v}"
channel: {channel}
---

{para}

<p><b>Highlighted bugfixes:</b></p>
<ul>
  <li>FIXME</li>
</ul>

See the <a href="/releases/{series}/#{v}">GStreamer {v} release notes</a>
for more details.

Binaries for Android, iOS, Mac OS X and Windows will be available shortly and
will be published on the <a href="/download/">Downloads page</a>.
""".format(title=title.replace('"', "'"), date=date.isoformat(),
           time=a.time, v=a.version, channel="stable" if stable else "devel", para=para, series=series)

    for path, content in writes.items():
        if path not in (spage, yml and yml[0]) and os.path.exists(path):
            sys.exit("%s already exists" % path)
        if a.dry_run:
            print("--- would write %s" % path)
            continue
        os.makedirs(os.path.dirname(path), exist_ok=True)
        with open(path, "w", encoding="utf-8") as f:
            f.write(content)
        print("wrote %s" % os.path.relpath(path, ROOT))

    print("""
Checklist:
  - fill in 'Highlighted bugfixes' (and module sections) in %s
  - polish the news item %s
  - (module tarballs/checksums are uploaded to the download host separately)
  - hugo --quiet && check /releases/%s/#%s
  - the home page and releases index update automatically from the series frontmatter
""" % (os.path.relpath(spage, ROOT), os.path.relpath(news, ROOT), series, a.version))


if __name__ == "__main__":
    main()
