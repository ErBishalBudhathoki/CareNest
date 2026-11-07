#!/usr/bin/env bash
# ---------------------------------------------------------------------------
# Stage store-ready phone screenshots into fastlane/metadata/android.
#
# The local Maestro "appstore-*" captures are 1320x2868 (~2.17:1), which Google
# Play rejects: phone screenshots must be 320-3840px per side with an aspect
# ratio of at most 2:1, and a production listing needs 2-8 of them. This script
# pads (never crops) to exactly 2:1, downscales to 1080x2160 and strips alpha.
#
# NOTE: those captures contain demo-account data. Review the staged images and
# replace any that show real names or client details before committing them.
# Nothing here is uploaded automatically.
# ---------------------------------------------------------------------------
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC="${1:-$ROOT/.maestro/screenshots/screenshots}"
DST="$ROOT/android/fastlane/metadata/android/en-US/images/phoneScreenshots"

if [[ ! -d "$SRC" ]]; then
  echo "ERROR: screenshot source directory not found: $SRC" >&2
  echo "Pass a directory containing appstore-*.png as the first argument." >&2
  exit 1
fi

PYTHON=""
for candidate in \
  "$ROOT/.venv-cairosvg/bin/python" \
  "$ROOT/.venv/bin/python" \
  "$(command -v python3 || true)"; do
  if [[ -n "$candidate" && -x "$candidate" ]] && \
     "$candidate" -c "import PIL" >/dev/null 2>&1; then
    PYTHON="$candidate"
    break
  fi
done

if [[ -z "$PYTHON" ]]; then
  echo "ERROR: Pillow is required. Install it with: python3 -m pip install Pillow" >&2
  exit 1
fi

SRC="$SRC" DST="$DST" "$PYTHON" - <<'PY'
import os
import shutil
from pathlib import Path
from PIL import Image

src = Path(os.environ['SRC'])
dst = Path(os.environ['DST'])
MAX_SHOTS = 8
TARGET_W, TARGET_H = 1080, 2160  # exactly 2:1, inside Play's limits

captures = sorted(p for p in src.glob('appstore-*.png') if p.is_file())
if not captures:
    raise SystemExit(f'ERROR: no appstore-*.png captures found in {src}')
if len(captures) > MAX_SHOTS:
    captures = captures[:MAX_SHOTS]
    print(f'NOTE: using the first {MAX_SHOTS} captures (Play allows at most 8).')

dst.mkdir(parents=True, exist_ok=True)
for old in dst.glob('*.png'):
    old.unlink()

for index, capture in enumerate(captures, start=1):
    with Image.open(capture) as raw:
        image = raw.convert('RGB')
    w, h = image.size
    # Pad the SHORT side so the long side / short side == 2, preserving all
    # content. Cropping would cut the status bar / bottom navigation.
    if h / w > 2.0:
        needed_w = (h + 1) // 2
        canvas = Image.new('RGB', (needed_w, h), (255, 255, 255))
        canvas.paste(image, ((needed_w - w) // 2, 0))
        image = canvas
    elif w / h > 2.0:
        needed_h = (w + 1) // 2
        canvas = Image.new('RGB', (w, needed_h), (255, 255, 255))
        canvas.paste(image, (0, (needed_h - h) // 2))
        image = canvas
    image = image.resize((TARGET_W, TARGET_H), Image.LANCZOS)
    out = dst / f'{index}_{capture.stem}.png'
    image.save(out, 'PNG', optimize=True)
    print(f'  {capture.name} -> {out.name}  {TARGET_W}x{TARGET_H}  {out.stat().st_size} bytes')

print(f'Staged {len(captures)} screenshots in {dst}')
print('Review them for demo/real personal data before committing.')
PY
