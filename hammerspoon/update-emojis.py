#!/usr/bin/env python3
"""Regenerate emojis.json, the data file behind emoji.lua's chooser.

Pulls the emoji list from Unicode's emoji-test.txt and search keywords from
CLDR's English annotations, then writes rows in exactly the shape
hs.chooser wants so emoji.lua can hand them over without any per-row work:

    [{"text": "<emoji> <name>", "subText": "<keywords>", "chars": "<emoji>"}]

Usage: ./update-emojis.py [--max-version 16.0] [--skin-tones]
"""

import argparse
import json
import re
import sys
import urllib.request
import xml.etree.ElementTree as ET
from pathlib import Path

EMOJI_TEST = "https://unicode.org/Public/emoji/latest/emoji-test.txt"
CLDR = "https://raw.githubusercontent.com/unicode-org/cldr/main/common/{}/en.xml"
SKIN_TONES = {0x1F3FB, 0x1F3FC, 0x1F3FD, 0x1F3FE, 0x1F3FF}

# "1F468 200D 1F469 ; fully-qualified # 👨‍👩 E2.0 couple"
LINE = re.compile(r"^([0-9A-F ]+);\s*(\S+)\s*#\s+\S+\s+E(\d+\.\d+)\s+(.+)$")


def fetch(url):
    print(f"fetching {url}", file=sys.stderr)
    with urllib.request.urlopen(url) as response:
        return response.read().decode("utf-8")


def annotations():
    """Map emoji -> (name, [keywords]) from CLDR, including derived sequences."""
    result = {}
    for directory in ("annotations", "annotationsDerived"):
        root = ET.fromstring(fetch(CLDR.format(directory)))
        for node in root.iter("annotation"):
            chars = node.get("cp")
            name, keywords = result.get(chars, (None, []))
            if node.get("type") == "tts":
                name = node.text
            else:
                keywords = [k.strip() for k in (node.text or "").split("|")]
            result[chars] = (name, keywords)
    return result


def emoji_rows(max_version, skin_tones):
    cldr = annotations()
    group = ""
    for line in fetch(EMOJI_TEST).splitlines():
        if line.startswith("# group:"):
            group = line.split(":", 1)[1].strip()
            continue

        match = LINE.match(line)
        if not match:
            continue
        codepoints, status, version, name = match.groups()

        if status != "fully-qualified" or group == "Component":
            continue
        if float(version) > max_version:
            continue
        points = [int(c, 16) for c in codepoints.split()]
        if not skin_tones and SKIN_TONES.intersection(points):
            continue

        chars = "".join(chr(c) for c in points)
        cldr_name, keywords = cldr.get(chars, (None, []))
        # Group names ("Food & Drink") make good search terms; word-splitting
        # them also lets "food" match. Keywords already in the name are dropped:
        # the chooser searches the name too, so they would only bloat the file.
        name = cldr_name or name
        haystack = name.lower()
        keywords += re.findall(r"\w+", group.lower())
        keywords = dict.fromkeys(k for k in keywords if k and k not in haystack)

        yield {"text": f"{chars} {name}", "subText": ", ".join(keywords), "chars": chars}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--max-version",
        type=float,
        default=16.0,
        help="skip emoji newer than this Unicode emoji version, which macOS "
        "would render as tofu (default: %(default)s)",
    )
    parser.add_argument(
        "--skin-tones",
        action="store_true",
        help="include skin tone variants (roughly triples the list)",
    )
    args = parser.parse_args()

    rows = list(emoji_rows(args.max_version, args.skin_tones))
    out = Path(__file__).parent / "emojis.json"
    out.write_text(json.dumps(rows, ensure_ascii=False))
    print(f"wrote {len(rows)} emoji to {out}", file=sys.stderr)


if __name__ == "__main__":
    main()
