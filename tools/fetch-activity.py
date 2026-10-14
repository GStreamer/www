#!/usr/bin/env python3
"""Refresh site-data/activity.json from the public GitLab API (no token needed).

Stdlib only. Never fails the build: every field falls back to the value
already committed in site-data/activity.json when a request fails or is rate
limited, and the script always exits 0 (unless --strict is given).

Usage: tools/fetch-activity.py [--out site-data/activity.json] [--strict]
"""
import argparse
import datetime as dt
import json
import os
import sys
import time
import urllib.error
import urllib.parse
import urllib.request

HOST = os.environ.get("GITLAB_HOST", "https://gitlab.freedesktop.org")
# The numbers cover the monorepo and the two Rust repositories, which are
# developed separately: id -> short name.
PROJECTS = {1357: "gstreamer", 1398: "gstreamer-rs", 1400: "gst-plugins-rs"}
MAIN = 1357  # the project whose tags are the releases
TIMEOUT = 20
MAX_RETRY_WAIT = 30  # never sleep longer than this on a 429


class Abort(Exception):
    """Stop fetching (rate limited for too long): keep fallbacks."""


def get(path, project=MAIN, **params):
    """Return (json, headers). Raises on error; retries once on 429."""
    url = f"{HOST}/api/v4/projects/{project}{path}?{urllib.parse.urlencode(params)}"
    req = urllib.request.Request(url, headers={"User-Agent": "gstreamer-www-activity/1.0"})
    for attempt in range(2):
        try:
            with urllib.request.urlopen(req, timeout=TIMEOUT) as r:
                return json.load(r), r.headers
        except urllib.error.HTTPError as e:
            if e.code == 429 and attempt == 0:
                wait = int(e.headers.get("Retry-After", "5") or 5)
                if wait > MAX_RETRY_WAIT:
                    raise Abort("rate limited")
                time.sleep(wait)
                continue
            if e.code == 429:
                raise Abort("rate limited")
            raise
    raise Abort("rate limited")


def total(path, **params):
    """Sum of X-Total over all the projects."""
    n = 0
    for project in PROJECTS:
        _, h = get(path, project=project, per_page=1, **params)
        t = h.get("X-Total")
        if t is None:
            raise ValueError("no X-Total header")
        n += int(t)
    return n


def iso(d):
    return d.strftime("%Y-%m-%dT%H:%M:%SZ")


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--out", default="site-data/activity.json")
    ap.add_argument("--strict", action="store_true", help="exit 1 if any field failed")
    args = ap.parse_args()

    try:
        with open(args.out) as f:
            data = json.load(f)
    except (OSError, ValueError):
        data = {}

    now = dt.datetime.now(dt.timezone.utc)
    d30 = iso(now - dt.timedelta(days=30))
    d12m = iso(now - dt.timedelta(days=365))
    errors = []

    def field(key, fn):
        if errors and errors[-1] == "abort":
            return
        try:
            data[key] = fn()
        except Abort as e:
            errors.append("abort")
            print(f"warning: {key}: {e}; stopping, keeping fallbacks", file=sys.stderr)
        except Exception as e:  # noqa: BLE001 - never fail the build
            errors.append(key)
            print(f"warning: {key}: {e}; keeping previous value", file=sys.stderr)


    def commits_30d():
        # the commits endpoint has no X-Total: count by paging (max 50 pages)
        n = 0
        for project in PROJECTS:
            for page in range(1, 51):
                c, h = get("/repository/commits", project=project, since=d30, per_page=100, page=page)
                n += len(c)
                if not h.get("X-Next-Page"):
                    break
            else:
                raise ValueError("too many commits to count")
        return n

    field("commits_30d", commits_30d)
    field("mrs_merged_30d", lambda: total("/merge_requests", state="merged", merged_after=d30))
    field("mrs_merged_12m", lambda: total("/merge_requests", state="merged", merged_after=d12m))
    field("mrs_open", lambda: total("/merge_requests", state="opened"))
    field("issues_updated_30d", lambda: total("/issues", updated_after=d30))

    def contributors():
        # the same person often contributes to several repositories: count them once
        people = set()
        for project in PROJECTS:
            for page in range(1, 51):
                c, h = get("/repository/contributors", project=project, per_page=100, page=page)
                people.update((x.get("email") or x["name"]).lower() for x in c)
                if not h.get("X-Next-Page"):
                    break
        return len(people)

    field("contributors", contributors)

    def tags():
        t, _ = get("/repository/tags", per_page=8, order_by="updated", sort="desc")
        return [{"name": x["name"], "date": (x.get("commit") or {}).get("created_at", "")}
                for x in t]

    field("tags", tags)

    def recent():
        out = []
        for project, name in PROJECTS.items():
            c, _ = get("/repository/commits", project=project, per_page=8)
            out += [{"title": x["title"], "author": x["author_name"], "repo": name,
                     "date": x["created_at"], "web_url": x["web_url"]} for x in c]
        out.sort(key=lambda x: dt.datetime.fromisoformat(x["date"]), reverse=True)
        return out[:8]

    field("recent_commits", recent)

    data.setdefault("recent_commits", [])
    data["fetchedAt"] = iso(now)
    if errors:
        data["source"] = "gitlab.freedesktop.org API (partial, some fields from committed fallback)"
    else:
        data["source"] = "gitlab.freedesktop.org API, projects " + ", ".join(PROJECTS.values())

    os.makedirs(os.path.dirname(os.path.abspath(args.out)), exist_ok=True)
    tmp = args.out + ".tmp"
    with open(tmp, "w") as f:
        json.dump(data, f, indent=2)
        f.write("\n")
    os.replace(tmp, args.out)
    print(f"wrote {args.out} ({len(errors)} field(s) kept from fallback)")
    return 1 if (errors and args.strict) else 0


if __name__ == "__main__":
    try:
        sys.exit(main())
    except Exception as e:  # noqa: BLE001
        print(f"warning: fetch-activity failed: {e}", file=sys.stderr)
        sys.exit(0)
