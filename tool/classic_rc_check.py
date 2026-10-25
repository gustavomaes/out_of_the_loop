#!/usr/bin/env python3
"""Inspect a built iOS .app; does not certify signing, billing or TestFlight."""
import argparse
import hashlib
import json
from pathlib import Path
import plistlib


def inspect(app):
    with (app / 'Info.plist').open('rb') as source:
        info = plistlib.load(source)
    assert info['CFBundleIdentifier'] == 'com.mathsquirrels.outoftheloop', 'Bundle ID changed'
    assert set(info['UIDeviceFamily']) == {1, 2}, 'iPhone/iPad support missing'
    for key in ('UISupportedInterfaceOrientations', 'UISupportedInterfaceOrientations~ipad'):
        assert {'UIInterfaceOrientationPortrait', 'UIInterfaceOrientationLandscapeLeft',
                'UIInterfaceOrientationLandscapeRight'} <= set(info[key]), key
    assets = app / 'Frameworks/App.framework/flutter_assets'
    assert assets.is_dir(), 'Flutter asset bundle missing'
    files = sorted(str(p.relative_to(app)) for p in app.rglob('*') if p.is_file())
    retired = ('seed_content.json', 'us_game_night.json', 'how_to_play_party.png',
               'firebase_crashlytics', 'FirebaseCrashlytics')
    assert not any(name in file for file in files for name in retired), 'Retired asset/plugin bundled'
    assert (assets / 'assets/sounds/theme.mp3').is_file(), 'Music missing'
    assert (assets / 'assets/images/app_icon.png').is_file(), 'Icon source missing'
    assert info.get('CFBundleIcons'), 'Native app icons missing'
    hashes = {}
    for relative in (info['CFBundleExecutable'], 'Frameworks/App.framework/App'):
        hashes[relative] = hashlib.sha256((app / relative).read_bytes()).hexdigest()
    return {
        'bundleId': info['CFBundleIdentifier'],
        'version': info['CFBundleShortVersionString'],
        'build': info['CFBundleVersion'],
        'platform': info['CFBundleSupportedPlatforms'],
        'sha256': hashes,
        'retiredAssetsAndCrashlyticsAbsent': True,
        'note': 'Local .app inspection only; signing, IPA, commerce and TestFlight unverified.',
    }


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('app', type=Path)
    args = parser.parse_args()
    print(json.dumps(inspect(args.app), indent=2))
