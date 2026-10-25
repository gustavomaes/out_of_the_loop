#!/usr/bin/env python3
"""Print Classic equivalents of legacy words without copying Guided questions.

Usage: python3 tool/classic_convert_legacy.py > /tmp/classic-legacy.json
The explicit mapping is authoritative; unknown references fail, never get guessed.
"""
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def convert():
    catalog = json.loads((ROOT / 'assets/content/classic_catalog.json').read_text())
    mapping = catalog['legacyWordIds']
    result = {}
    for bank in ['seed_content', 'us_game_night']:
        source = json.loads((ROOT / f'assets/content/{bank}.json').read_text())
        for category in source['categories']:
            for word in category['words']:
                for lang, text in word['value'].items():
                    old = f"{lang}:{category['id']}:{word['id']}"
                    target = mapping[old].split('/')
                    entry = result.setdefault(target[2], {
                        'id': target[2], 'categoryId': target[1], 'value': {},
                        'legacyReferences': []})
                    assert entry['value'].get(lang, text) == text
                    entry['value'][lang] = text
                    entry['legacyReferences'].append(old)
    return {'schemaVersion': 1, 'words': list(result.values())}


if __name__ == '__main__':
    print(json.dumps(convert(), ensure_ascii=False, indent=2))
