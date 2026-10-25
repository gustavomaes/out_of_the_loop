#!/usr/bin/env python3
"""Check local publication evidence integrity, never authorize store release."""
import hashlib
import json
from pathlib import Path
import re
import subprocess

ROOT = Path(__file__).resolve().parents[1]
PACKAGE = ROOT / 'docs/classic/publication'


def check():
    manifest = json.loads((PACKAGE / 'manifest.json').read_text())
    assert manifest['schemaVersion'] == 1, 'Unknown manifest schema'
    assert manifest['bundleId'] == 'com.mathsquirrels.outoftheloop', 'Bundle ID changed'
    version = re.search(r'^version:\s*(\S+)', (ROOT / 'pubspec.yaml').read_text(), re.M)
    assert version and version[1] == manifest['sourceVersion'], 'Source version drift'
    subprocess.run(['git', 'cat-file', '-e', manifest['sourceRevision'] + '^{commit}'],
                   cwd=ROOT, check=True, capture_output=True)
    for filename in ['CHECKLIST.md', 'METADATA_en-US.md', 'REVIEW_NOTES.md',
                     'HOTFIX.md', 'reports/D7.md', 'reports/D14.md', 'reports/D30.md']:
        assert (PACKAGE / filename).stat().st_size > 0, f'Missing artifact: {filename}'
    for shot in manifest['screenshots']:
        path = (PACKAGE / shot['path']).resolve()
        assert path.is_relative_to(ROOT / 'docs/classic'), 'Screenshot outside evidence tree'
        assert hashlib.sha256(path.read_bytes()).hexdigest() == shot['sha256'], 'Screenshot drift'
        assert (PACKAGE / shot['provenance']).is_file(), 'Missing screenshot provenance'
        assert shot['status'] == 'historical_simulator_evidence_not_store_ready'
    # This version checks a preparation package only. Closing gates requires a new
    # evidence review, not flipping a boolean to manufacture release approval.
    assert manifest['status'] == 'blocked' and manifest['blockers'], 'Review gate missing'
    assert manifest['signedCandidate'] is None and manifest['launchAt'] is None
    assert manifest['storeVersionVerified'] is False
    print('PASS: local package integrity; BLOCKED: store release gates remain open.')
    for blocker in manifest['blockers']:
        print(f'  pending: {blocker}')


if __name__ == '__main__':
    check()
