#!/usr/bin/env python3
#
# Generate security advisory table summary lines for the given advisory files
#
# SPDX-License-Identifier: MPL-2.0
import sys

"""
Parses a GStreamer security advisory file and formats it into a markdown table summary row.
"""


def parse_gstreamer_advisory(advisory_filename):
    try:
        with open(advisory_filename, 'r', encoding='utf-8') as f:
            content = f.read()
    except Exception as e:
        sys.exit(f'Error reading file: {e}')

    def get_table_entry(line):
        fields = line.split('|')
        return fields[2].strip()

    summary = None
    date = None
    ids = None

    # Extract fields
    for line in content.split('\n'):
        if line.startswith('| Summary'):
            summary = get_table_entry(line)
        elif line.startswith('| Date'):
            date = get_table_entry(line)
        elif line.startswith('| IDs'):
            ids = get_table_entry(line)

    if summary and date and ids:
        pass
    else:
        sys.exit(f'Could not extract all the fields from {advisory_filename}')

    if '<br' in ids:
        sa_id = ids.split('<br')[0]
    else:
        sa_id = ids

    formatted_sa_id = f'**{sa_id}**'

    formatted_ids = ids.replace(sa_id, formatted_sa_id)

    html_filename = advisory_filename.replace('.md', '.html')

    return f"| {formatted_ids} | {summary} | {date} | [Details]({html_filename}) |"

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python parse_advisory.py <sa-20xx-xxxx.md>")
        sys.exit(1)

    for input_source in sys.argv[1:]:
        markdown_line = parse_gstreamer_advisory(input_source)
        print(markdown_line)
