#!/usr/bin/env python3
"""Derive a pixel-exact screen mask + geometry from a Screeny iPhone frame PNG.

The frame assets in ``screeny-iphone-frames/`` are RGBA overlays: the metal
bezel and Dynamic Island are opaque, the display area and the surrounding
canvas are transparent. We flood-fill the transparent region connected to the
image border ("outside the phone"); the transparent region left over is the
display cutout. The mask is white where the display shows through and clear
everywhere else, with ``255 - frame_alpha`` soft edges so the anti-aliased
inner bezel edge blends instead of producing a white halo.

Outputs (self-contained, so render.py never depends on the source folder):
    assets/iphone-18-pro-max-black.png   verbatim copy of the chosen frame
    assets/iphone-screen-mask.png        RGBA cutout mask, same pixel grid
    assets/frame-meta.json               cutout rect + measured radii

Run once whenever the frame asset changes:
    python3 make_frame_asset.py
"""
import json
import pathlib
import shutil
import struct
import zlib
from collections import deque

PIPE = pathlib.Path(__file__).resolve().parent
ROOT = PIPE.parents[1]
ASSETS = PIPE / "assets"
FRAME_NAME = "iphone-18-pro-max-black.png"
FRAME_SRC = ROOT / "screeny-iphone-frames" / FRAME_NAME


def chunk(typ, payload):
    return (struct.pack(">I", len(payload)) + typ + payload
            + struct.pack(">I", zlib.crc32(typ + payload) & 0xFFFFFFFF))


def write_rgba_png(path, w, h, rgba):
    stride = w * 4
    raw = bytearray()
    for y in range(h):
        raw.append(0)                       # filter type 0 (None)
        raw += rgba[y * stride:(y + 1) * stride]
    data = (b"\x89PNG\r\n\x1a\n"
            + chunk(b"IHDR", struct.pack(">IIBBBBB", w, h, 8, 6, 0, 0, 0))
            + chunk(b"IDAT", zlib.compress(bytes(raw), 9))
            + chunk(b"IEND", b""))
    path.write_bytes(data)


def decode_rgba(path):
    b = pathlib.Path(path).read_bytes()
    assert b[:8] == b"\x89PNG\r\n\x1a\n", "not a PNG"
    pos, idat = 8, bytearray()
    w = h = bd = ct = inter = None
    while pos < len(b):
        ln = struct.unpack(">I", b[pos:pos + 4])[0]
        typ = b[pos + 4:pos + 8]
        data = b[pos + 8:pos + 8 + ln]
        if typ == b"IHDR":
            w, h, bd, ct, comp, filt, inter = struct.unpack(">IIBBBBB", data)
        elif typ == b"IDAT":
            idat += data
        elif typ == b"IEND":
            break
        pos += 12 + ln
    assert bd == 8 and ct == 6 and inter == 0, (bd, ct, inter)
    raw = zlib.decompress(bytes(idat))
    bpp, stride = 4, w * 4
    out = bytearray(h * stride)
    prev = bytearray(stride)
    off = 0
    for y in range(h):
        ft = raw[off]; off += 1
        line = bytearray(raw[off:off + stride]); off += stride
        if ft == 1:
            for i in range(bpp, stride):
                line[i] = (line[i] + line[i - bpp]) & 255
        elif ft == 2:
            for i in range(stride):
                line[i] = (line[i] + prev[i]) & 255
        elif ft == 3:
            for i in range(stride):
                a = line[i - bpp] if i >= bpp else 0
                line[i] = (line[i] + ((a + prev[i]) >> 1)) & 255
        elif ft == 4:
            for i in range(stride):
                a = line[i - bpp] if i >= bpp else 0
                c = prev[i - bpp] if i >= bpp else 0
                p = a + prev[i] - c
                pa, pb, pc = abs(p - a), abs(p - prev[i]), abs(p - c)
                pr = a if (pa <= pb and pa <= pc) else (prev[i] if pb <= pc else c)
                line[i] = (line[i] + pr) & 255
        elif ft != 0:
            raise ValueError(f"unsupported PNG filter {ft}")
        out[y * stride:(y + 1) * stride] = line
        prev = line
    return w, h, out


def main():
    ASSETS.mkdir(parents=True, exist_ok=True)
    if not FRAME_SRC.exists():
        raise SystemExit(f"missing frame asset: {FRAME_SRC}")
    w, h, px = decode_rgba(FRAME_SRC)
    alpha = bytearray(px[3::4])                       # one byte per pixel
    n = w * h

    # Flood fill the transparent region reachable from the image border.
    outside = bytearray(n)
    q = deque()
    for x in range(w):
        for y in (0, h - 1):
            i = y * w + x
            if alpha[i] < 128 and not outside[i]:
                outside[i] = 1; q.append(i)
    for y in range(h):
        for x in (0, w - 1):
            i = y * w + x
            if alpha[i] < 128 and not outside[i]:
                outside[i] = 1; q.append(i)
    while q:
        i = q.popleft()
        x, y = i % w, i // w
        for j in (i - 1 if x > 0 else -1,
                  i + 1 if x < w - 1 else -1,
                  i - w if y > 0 else -1,
                  i + w if y < h - 1 else -1):
            if j >= 0 and alpha[j] < 128 and not outside[j]:
                outside[j] = 1; q.append(j)

    # Mask = inverse of frame alpha, except the outside region is forced clear.
    mask = bytearray(n * 4)
    cut_px = []
    for i in range(n):
        a = 0 if outside[i] else 255 - alpha[i]
        if a:
            mask[i * 4:i * 4 + 4] = b"\xff\xff\xff" + bytes((a,))
            if a >= 250:
                cut_px.append(i)

    # Exact cutout bounding box from fully-clear mask pixels.
    xs = [i % w for i in cut_px]
    ys = [i // w for i in cut_px]
    cx0, cx1, cy0, cy1 = min(xs), max(xs), min(ys), max(ys)
    opaque_left = min(i % w for i in range(n) if alpha[i] >= 250 and not outside[i])

    # Inner radius: at the topmost cutout row, the leading inset equals r for a
    # circular arc (a squircle has a slightly longer tail; report the fit).
    def left_edge_of_run(y):
        best, start, prev = (0, 0, 0), None, None
        for x in list(range(w)) + [10 ** 9]:
            if alpha[y * w + x] < 128 if x < w else False:
                if start is None:
                    start = prev = x
                elif x == prev + 1:
                    prev = x
                else:
                    if prev - start + 1 > best[0]:
                        best = (prev - start + 1, start, prev)
                    start = prev = x
        return best

    _, run_x0, _ = left_edge_of_run(h // 2)
    _, top_run_x0, _ = left_edge_of_run(cy0 + 1)
    inner_r = top_run_x0 - run_x0
    bezel = cx0 - opaque_left                        # real metal bezel thickness
    outer_r = inner_r + bezel                        # concentric-radius relation

    shutil.copy2(FRAME_SRC, ASSETS / FRAME_NAME)
    write_rgba_png(ASSETS / "iphone-screen-mask.png", w, h, mask)
    meta = {
        "frame": FRAME_NAME,
        "frame_w": w, "frame_h": h,
        "cut_x": cx0, "cut_y": cy0,
        "cut_w": cx1 - cx0 + 1, "cut_h": cy1 - cy0 + 1,
        "bezel": bezel, "inner_r": inner_r, "outer_r": outer_r,
        "mask_pixels": len(cut_px),
    }
    (ASSETS / "frame-meta.json").write_text(json.dumps(meta, indent=2) + "\n")
    print(json.dumps(meta, indent=2))
    print(f"mask fraction of canvas: {len(cut_px)/n:.1%}")


if __name__ == "__main__":
    main()
