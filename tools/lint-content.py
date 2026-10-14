#!/usr/bin/env python3
"""Validate front matter of content/ files.  Stdlib only.

Required keys per section (see CONTRIBUTING.md):

  news/*.md                   title, date
  releases/<series>/_index.md title, series, status
  security/*.md               id, date, title
  conference/<year>/_index.md year, status
  modules/*.md, bindings/*.md title, status

Usage: python3 tools/lint-content.py [--content content]
Exit status 1 when any error is found.
"""
import argparse
import os
import re
import sys

DATE_RE = re.compile(r"^\d{4}-\d{2}-\d{2}([T ]\d{2}:\d{2}(:\d{2})?([.\d]*)?(Z|[+-]\d{2}:?\d{2})?)?$")


def split_front_matter(text):
    """Return (dict of top-level key -> raw value, error or None)."""
    if text.startswith("+++"):
        end = text.find("\n+++", 3)
        if end < 0:
            return None, "unterminated TOML front matter (missing closing +++)"
        body, sep = text[3:end], "="
    elif text.startswith("---"):
        m = re.search(r"^---\s*$", text[3:], re.M)
        if not m:
            return None, "unterminated front matter (missing closing ---)"
        body, sep = text[3:3 + m.start()], ":"
    else:
        return None, "no front matter (file must start with --- )"
    keys = {}
    last = None
    for line in body.splitlines():
        m = re.match(r"^([A-Za-z_][\w-]*)\s*" + sep + r"\s*(.*?)\s*$", line)
        if m and not line.startswith((" ", "\t")):
            last = m.group(1)
            keys[last] = m.group(2)
        elif last and line.strip() and keys[last] == "":
            keys[last] = line.strip()  # nested value or list item
    return keys, None


def unquote(v):
    return v.strip().strip("\"'")


def check(path, rel, required, extra=None):
    errs = []
    try:
        text = open(path, encoding="utf-8").read()
    except (OSError, UnicodeDecodeError) as e:
        return [f"{rel}: cannot read file: {e}"]
    fm, err = split_front_matter(text)
    if err:
        return [f"{rel}: {err}"]
    for k in required:
        if k not in fm:
            errs.append(f"{rel}: missing required front matter key '{k}'")
        elif fm[k] == "":
            errs.append(f"{rel}: front matter key '{k}' is empty")
    if "date" in fm and fm["date"] and not DATE_RE.match(unquote(fm["date"])):
        errs.append(f"{rel}: 'date' is not a valid date (use YYYY-MM-DD): {fm['date']}")
    if extra:
        errs += [f"{rel}: {e}" for e in extra(fm)]
    return errs


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--content", default="content")
    args = ap.parse_args()
    root = args.content
    if not os.path.isdir(root):
        print(f"error: {root} not found", file=sys.stderr)
        return 2

    errors = []
    count = 0

    def md_files(sub, recursive=False):
        base = os.path.join(root, sub)
        if not os.path.isdir(base):
            return
        for d, dirs, files in os.walk(base):
            for f in sorted(files):
                if f.endswith(".md"):
                    yield os.path.join(d, f)
            if not recursive:
                break

    for p in md_files("news"):
        if os.path.basename(p) != "_index.md":
            count += 1
            errors += check(p, os.path.relpath(p, root), ["title", "date"])

    for p in md_files("security"):
        if os.path.basename(p) != "_index.md":
            count += 1
            errors += check(p, os.path.relpath(p, root), ["id", "date", "title"])

    for sub in ("modules", "bindings"):
        for p in md_files(sub):
            if os.path.basename(p) != "_index.md":
                count += 1
                errors += check(p, os.path.relpath(p, root), ["title", "status"])

    rel_dir = os.path.join(root, "releases")
    if os.path.isdir(rel_dir):
        for d in sorted(os.listdir(rel_dir)):
            p = os.path.join(rel_dir, d, "_index.md")
            if os.path.isdir(os.path.join(rel_dir, d)):
                rel = os.path.relpath(p, root)
                if not os.path.isfile(p):
                    errors.append(f"{rel}: release series directory has no _index.md")
                    continue
                count += 1

                def series_check(fm, d=d):
                    s = unquote(fm.get("series", ""))
                    return [f"'series' ({s}) does not match directory name ({d})"] \
                        if s and s != d else []
                errors += check(p, rel, ["title", "series", "status"], series_check)

    conf = os.path.join(root, "conference")
    if os.path.isdir(conf):
        for d in sorted(os.listdir(conf)):
            if re.fullmatch(r"\d{4}", d) and os.path.isdir(os.path.join(conf, d)):
                p = os.path.join(conf, d, "_index.md")
                rel = os.path.relpath(p, root)
                if not os.path.isfile(p):
                    errors.append(f"{rel}: conference year directory has no _index.md")
                    continue
                count += 1

                def year_check(fm, d=d):
                    y = unquote(fm.get("year", ""))
                    return [f"'year' ({y}) does not match directory name ({d})"] \
                        if y and y != d else []
                errors += check(p, rel, ["year", "status"], year_check)

    for e in errors:
        print("error:", e)
    print(f"checked {count} content files, {len(errors)} error(s)")
    return 1 if errors else 0


if __name__ == "__main__":
    sys.exit(main())
