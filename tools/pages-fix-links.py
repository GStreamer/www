#!/usr/bin/env python3
"""Make a preview build (GitLab Pages) self-contained.

The new site does not contain everything the real site serves: release
tarballs (src/), the API documentation (documentation/), the planet, old
downloads and a few images live on the web server, outside this repository.
In a preview those relative links would all be 404s, so this script rewrites
every relative link or image that does not exist in the build output into an
absolute link to the live site.

Stdlib only.  Usage (after hugo --baseURL / with HUGO_RELATIVEURLS=true):

  python3 tools/pages-fix-links.py public https://gstreamer.freedesktop.org

Never use this for the real deployment: there the links are served by the
web server itself.
"""
import os
import re
import sys
from urllib.parse import unquote, urljoin, urlsplit

ATTR = re.compile(r'''(\b(?:href|src)=)(["'])([^"']*)\2''')


def exists(public, path):
    p = os.path.join(public, unquote(path).lstrip("/"))
    if os.path.isfile(p):
        return True
    return os.path.isdir(p) and os.path.isfile(os.path.join(p, "index.html"))


def main():
    if len(sys.argv) != 3:
        sys.exit(__doc__)
    public, live = sys.argv[1], sys.argv[2].rstrip("/")
    changed_files = changed_links = 0
    for root, _dirs, files in os.walk(public):
        for name in files:
            if not name.endswith(".html"):
                continue
            path = os.path.join(root, name)
            url = "/" + os.path.relpath(path, public).replace(os.sep, "/")
            text = open(path, encoding="utf-8", errors="surrogateescape").read()
            count = 0

            def fix(m):
                nonlocal count
                attr, quote, value = m.groups()
                sp = urlsplit(value)
                if sp.scheme or sp.netloc or not sp.path:
                    return m.group(0)  # absolute, "#anchor", "?query" or empty
                target = urljoin(url, sp.path)
                if exists(public, target):
                    return m.group(0)
                count += 1
                new = live + target
                if sp.query:
                    new += "?" + sp.query
                if sp.fragment:
                    new += "#" + sp.fragment
                return attr + quote + new + quote

            out = ATTR.sub(fix, text)
            if count:
                open(path, "w", encoding="utf-8", errors="surrogateescape").write(out)
                changed_files += 1
                changed_links += count
    print("rewrote %d links to %s in %d pages" % (changed_links, live, changed_files))


if __name__ == "__main__":
    main()
