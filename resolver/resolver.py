#!/usr/bin/env python3

import random
from pathlib import Path

MUSIC_ROOT = Path('/srv/libretime/imported')

SUPPORTED = ['.mp3', '.flac', '.wav', '.ogg']

tracks = []

for ext in SUPPORTED:
    tracks.extend(MUSIC_ROOT.rglob(f'*{ext}'))

if not tracks:
    raise SystemExit('No tracks found.')

selected = random.choice(tracks)
print(selected)
