#!/usr/bin/env python3
"""Check the built site (Hugo output) for broken internal links and anchors.

Stdlib only.  Usage:

  hugo --destination public
  python3 tools/check-links.py [--public public]

Known broken links that already existed in the legacy content are listed in
tools/links-ignore.txt ("page -> link", one per line) and do not fail the check;
remove a line once the link is fixed.

Exit status 1 if an internal link or anchor is broken.  Links into the
directories that are deployed outside of this repository (data, src, pkg,
media, documentation, planet) and the old per-module release notes
(releases/<module>/<version>.html and similar) are not checked.
"""
import argparse
import os
import sys
from html.parser import HTMLParser
from urllib.parse import unquote, urldefrag, urljoin, urlsplit

EXTERNAL_DIRS = ("data", "src", "pkg", "media", "documentation", "planet")


class Page(HTMLParser):
    def __init__(self):
        super().__init__(convert_charrefs=True)
        self.links = []
        self.ids = set()

    def handle_starttag(self, tag, attrs):
        a = dict(attrs)
        for k in ("id", "name"):
            if a.get(k):
                self.ids.add(a[k])
        if tag in ("a", "link") and a.get("href"):
            self.links.append(a["href"])
        elif tag in ("img", "script", "source", "iframe", "video", "audio") and a.get("src"):
            self.links.append(a["src"])
        if tag == "img" and a.get("srcset"):
            for part in a["srcset"].split(","):
                if part.strip():
                    self.links.append(part.strip().split()[0])


def url_to_file(public, urlpath):
    """Map a URL path to a file in the build output, or None."""
    p = unquote(urlpath).lstrip("/")
    cand = os.path.join(public, p)
    if p == "" or p.endswith("/"):
        cand = os.path.join(cand, "index.html")
    if os.path.isfile(cand):
        return cand
    if os.path.isdir(cand) and os.path.isfile(os.path.join(cand, "index.html")):
        return os.path.join(cand, "index.html")
    return None


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--public", default="public")
    ap.add_argument("--ignore", default=os.path.join(os.path.dirname(__file__), "links-ignore.txt"))
    ap.add_argument("--max-report", type=int, default=200)
    args = ap.parse_args()

    if not os.path.isdir(args.public):
        print(f"error: {args.public} not found; run hugo first", file=sys.stderr)
        return 2

    pages = {}
    for root, _d, files in os.walk(args.public):
        for f in files:
            if f.endswith(".html"):
                path = os.path.join(root, f)
                p = Page()
                p.feed(open(path, errors="replace").read())
                pages[path] = p

    broken, bad_anchor = [], []
    nlinks = 0
    for path, p in sorted(pages.items()):
        url = "/" + os.path.relpath(path, args.public)
        for href in p.links:
            href = href.strip()
            sp = urlsplit(href)
            if sp.scheme or sp.netloc or not href:
                continue
            nlinks += 1
            full, frag = urldefrag(urljoin(url, href))
            target = urlsplit(full).path
            first = target.lstrip("/").split("/", 1)[0]
            if first in EXTERNAL_DIRS:
                continue
            parts = target.lstrip("/").split("/")
            if parts[0] == "releases" and len(parts) > 1 and parts[1] not in ("", "index.html") \
                    and not parts[1][:1].isdigit():
                continue  # release notes of single modules, served from the web server
            if href.startswith("#"):
                target_file = path
            else:
                target_file = url_to_file(args.public, target)
            if target_file is None:
                broken.append((url, href))
                continue
            if frag and target_file.endswith(".html"):
                tp = pages.get(target_file)
                if tp is not None and unquote(frag) not in tp.ids and frag not in tp.ids \
                        and frag != "top":
                    bad_anchor.append((url, href))

    ignored = set()
    if os.path.isfile(args.ignore):
        ignored = {l.strip() for l in open(args.ignore) if l.strip() and not l.startswith("#")}
    broken = [(u, h) for u, h in broken if f"{u} -> {h}" not in ignored]
    bad_anchor = [(u, h) for u, h in bad_anchor if f"{u} -> {h}" not in ignored]

    print(f"checked {len(pages)} pages, {nlinks} internal links")
    for title, items in (("Broken internal links", broken), ("Broken anchors", bad_anchor)):
        print(f"\n{title}: {len(items)}")
        for src, h in items[:args.max_report]:
            print(f"  {src} -> {h}")
        if len(items) > args.max_report:
            print(f"  ... {len(items) - args.max_report} more")
    return 1 if (broken or bad_anchor) else 0


if __name__ == "__main__":
    sys.exit(main())
