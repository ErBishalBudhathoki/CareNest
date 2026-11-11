#!/usr/bin/env python3
"""Read the binary PNG headers of every exported screenshot and verify specs.

Checks IHDR directly (no image library, no decoding of pixel data):
  - signature + IHDR width/height/bit depth/colour type
  - colour type 2 == 8-bit RGB / 3 channels (type 6 RGBA is a FAIL)
  - exact canvas per platform, 8 MiB cap on Google Play files
Prints a final verification table and exits non-zero on any failure.
"""
import pathlib
import struct
import sys

ROOT = pathlib.Path(__file__).resolve().parents[2]
EXPECT = {
    "ios": (1320, 2868),
    "android": (1080, 1920),
}
CT_NAME = {0: "Grayscale (1ch)", 2: "RGB (3ch)", 3: "Palette (1ch)", 4: "Gray+Alpha (2ch)", 6: "RGBA (4ch)"}


def read_ihdr(path):
    with open(path, "rb") as f:
        head = f.read(33)
    if head[:8] != b"\x89PNG\r\n\x1a\n":
        return None
    w, h, bd, ct, comp, filt, inter = struct.unpack(">IIBBBBB", head[16:29])
    return w, h, bd, ct, comp, filt, inter


def main():
    rows, failures = [], []
    for plat, (ew, eh) in EXPECT.items():
        d = ROOT / "store-screenshots" / plat
        files = sorted(d.glob("*.png")) if d.exists() else []
        if not files:
            failures.append(f"{plat}: no PNG files found in {d}")
        for p in files:
            hdr = read_ihdr(p)
            size = p.stat().st_size
            if hdr is None:
                failures.append(f"{p.name}: invalid PNG signature")
                continue
            w, h, bd, ct, comp, filt, inter = hdr
            ok = (w, h) == (ew, eh) and bd == 8 and ct == 2 and comp == 0 and filt == 0 and inter == 0
            if plat == "android" and size >= 8 * 1024 * 1024:
                ok = False
                failures.append(f"{p.name}: exceeds 8 MiB Google Play cap")
            if not ok:
                failures.append(f"{p.name}: got {w}x{h} bd={bd} ct={ct} (expected {ew}x{eh} bd=8 ct=2)")
            rows.append((plat, p.name, w, h, CT_NAME.get(ct, f"unknown({ct})"), size, "PASS" if ok else "FAIL"))

    print("| Platform | Filename | Width x Height | Colour type / channels | Size | Result |")
    print("|---|---|---|---|---|---|")
    for plat, name, w, h, ct, size, res in rows:
        sz = f"{size/1024:.0f} KB" if size < 1024 * 1024 else f"{size/1024/1024:.2f} MB"
        print(f"| {plat} | `{name}` | {w} x {h} | {ct} | {sz} | {res} |")
    print(f"\n{sum(1 for r in rows if r[6] == 'PASS')}/{len(rows)} files passed.")
    if failures:
        print("\nFAILURES:")
        for f in failures:
            print("  -", f)
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
