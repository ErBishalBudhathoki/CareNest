#!/usr/bin/env bash
# ---------------------------------------------------------------------------
# Stage the approved composed Play screenshots into fastlane/metadata/android.
#
# Source: store-screenshots/android/ — the deterministic HTML/CSS renderer in
# store-screenshots/pipeline/ produces 1080x1920 24-bit RGB PNGs that already
# satisfy Google Play's rules (2-8 phone shots, 320-3840px per side, portrait
# aspect ratio at most 2:1). This script copies them verbatim: no cropping,
# padding, resampling or pixel edits, and no Pillow dependency.
#
# Pass another directory as the first argument to override the source.
#
# Nothing is uploaded here. fastlane's promote_internal_to_production lane
# uploads this metadata directory; internal deploys skip metadata/screenshots.
# ---------------------------------------------------------------------------
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC="${1:-$ROOT/store-screenshots/android}"
DST="$ROOT/android/fastlane/metadata/android/en-US/images/phoneScreenshots"

if [[ ! -d "$SRC" ]]; then
  echo "ERROR: screenshot source directory not found: $SRC" >&2
  echo "Pass the directory containing the composed 1080x1920 PNGs." >&2
  exit 1
fi

SRC="$SRC" DST="$DST" python3 - <<'PY'
import os
import shutil
import struct
from pathlib import Path

src, dst = Path(os.environ["SRC"]), Path(os.environ["DST"])
MAX_SHOTS = 8

# APFS is case-insensitive by default; de-duplicate before counting.
shots = list({p.name.lower(): p for p in src.glob("*.png") if p.is_file()}.values())
shots.sort(key=lambda p: p.name.lower())
if not shots:
    raise SystemExit(f"ERROR: no PNG screenshots found in {src}")
if len(shots) > MAX_SHOTS:
    print(f"NOTE: using the first {MAX_SHOTS} of {len(shots)} shots (Play allows at most 8).")
    shots = shots[:MAX_SHOTS]

for p in shots:
    head = p.read_bytes()[:33]
    if head[:8] != b"\x89PNG\r\n\x1a\n":
        raise SystemExit(f"ERROR: {p.name} is not a PNG")
    w, h, depth, colour_type = struct.unpack(">IIBB", head[16:26])
    sides = (w, h)
    if not (320 <= min(sides) and max(sides) <= 3840):
        raise SystemExit(f"ERROR: {p.name} is {w}x{h}; Play requires 320-3840px per side")
    if max(sides) / min(sides) > 2.0:
        raise SystemExit(f"ERROR: {p.name} exceeds Play's 2:1 portrait aspect limit")
    if depth != 8 or colour_type != 2:
        raise SystemExit(f"ERROR: {p.name} must be 8-bit RGB (no alpha); got depth={depth} ct={colour_type}")
    if p.stat().st_size >= 8 * 1024 * 1024:
        raise SystemExit(f"ERROR: {p.name} exceeds Play's 8 MiB screenshot limit")

dst.mkdir(parents=True, exist_ok=True)
for old in dst.glob("*.png"):
    old.unlink()
for p in shots:
    shutil.copyfile(p, dst / p.name)
    print(f"  {p.name}  {p.stat().st_size // 1024} KB")

print(f"Staged {len(shots)} Play screenshots in {dst}")
PY
