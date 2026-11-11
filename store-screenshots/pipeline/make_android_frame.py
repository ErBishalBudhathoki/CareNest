#!/usr/bin/env python3
"""Generate a deterministic flat-2D Android device frame + screen mask.

No Android frame asset exists in this repo and fastlane's frameit frame host
(fastlane.github.io/frameit-frames) is dead, so the frame is drawn
analytically instead of downloaded. Coverage is computed from a signed
distance field, which gives exact 1px antialiasing with no supersampling and
no external image dependency.

Geometry obeys the concentric-radius rule by construction:
    outer_r = inner_r + bezel

Outputs (self-contained, so render.py never depends on a source folder):
    assets/android-frame.png         RGBA bezel overlay, transparent on screen
    assets/android-screen-mask.png   RGBA mask, white where the screen shows
    assets/android-frame-meta.json   cutout rect + radii

Run once whenever the frame geometry changes:
    python3 make_android_frame.py
"""
import json
import math
import pathlib
import struct
import zlib

PIPE = pathlib.Path(__file__).resolve().parent
ASSETS = PIPE / "assets"

# Screen is 110:239 (the CareNest capture aspect 1320:2868 reduced), so
# object-fit:contain fills the cutout exactly with zero letterboxing.
K = 6
SCREEN_W, SCREEN_H = 110 * K, 239 * K      # 660 x 1434
BEZEL = 20
INNER_R = 44
OUTER_R = INNER_R + BEZEL                  # 64 - concentric rule
BUTTON = 7                                 # side-button protrusion
PUNCH_R = round(0.030 * SCREEN_W)          # 20 - punch-hole camera
PUNCH_TOP = round(0.018 * SCREEN_H)        # 26 - from top of screen

FRAME_W = SCREEN_W + 2 * BEZEL             # 700
FRAME_H = SCREEN_H + 2 * BEZEL             # 1474
CANVAS_W = FRAME_W + 2 * BUTTON            # 710
CANVAS_H = FRAME_H                         # 1474
BODY_X0 = BUTTON
BODY_X1 = BUTTON + FRAME_W
SCR_X0 = BODY_X0 + BEZEL
SCR_Y0 = BEZEL
SCR_X1 = SCR_X0 + SCREEN_W
SCR_Y1 = SCR_Y0 + SCREEN_H

BEZEL_HEX = (0x18, 0x18, 0x1B)             # #18181B
BORDER_HEX = (0x27, 0x27, 0x2A)            # #27272A
PUNCH_HEX = (0x00, 0x00, 0x00)


def rrect_sdf(px, py, x0, y0, x1, y1, r):
    """Signed distance to a rounded rect; negative inside."""
    cx = min(max(px, x0 + r), x1 - r)
    cy = min(max(py, y0 + r), y1 - r)
    return math.hypot(px - cx, py - cy) - r


def cov(d):
    """1px-wide antialiased coverage from a signed distance."""
    v = 0.5 - d
    return 0.0 if v <= 0.0 else (1.0 if v >= 1.0 else v)


def chunk(typ, payload):
    return (struct.pack(">I", len(payload)) + typ + payload
            + struct.pack(">I", zlib.crc32(typ + payload) & 0xFFFFFFFF))


def write_rgba_png(path, w, h, rgba):
    stride = w * 4
    raw = bytearray()
    for y in range(h):
        raw.append(0)
        raw += rgba[y * stride:(y + 1) * stride]
    path.write_bytes(
        b"\x89PNG\r\n\x1a\n"
        + chunk(b"IHDR", struct.pack(">IIBBBBB", w, h, 8, 6, 0, 0, 0))
        + chunk(b"IDAT", zlib.compress(bytes(raw), 9))
        + chunk(b"IEND", b"")
    )


def main():
    ASSETS.mkdir(parents=True, exist_ok=True)
    w, h = CANVAS_W, CANVAS_H
    frame = bytearray(w * h * 4)
    mask = bytearray(w * h * 4)

    # Side buttons: (x0, x1, y0, y1) bands, rounded like real hardware keys.
    buttons = [
        (BODY_X1, BODY_X1 + BUTTON, round(0.20 * FRAME_H), round(0.30 * FRAME_H)),  # power
        (BODY_X1, BODY_X1 + BUTTON, round(0.36 * FRAME_H), round(0.44 * FRAME_H)),  # vol up
        (BODY_X1, BODY_X1 + BUTTON, round(0.45 * FRAME_H), round(0.53 * FRAME_H)),  # vol down
        (BODY_X0 - BUTTON, BODY_X0, round(0.28 * FRAME_H), round(0.36 * FRAME_H)),  # assistant
    ]
    BR = 3.0  # button corner radius

    punch_cx = (SCR_X0 + SCR_X1) / 2
    punch_cy = SCR_Y0 + PUNCH_TOP + PUNCH_R

    for y in range(h):
        py = y + 0.5
        row = y * w * 4
        for x in range(w):
            px = x + 0.5
            i = row + x * 4

            body = cov(rrect_sdf(px, py, BODY_X0, 0, BODY_X1, h, OUTER_R))
            if body <= 0.0:
                for bx0, bx1, by0, by1 in buttons:
                    if bx0 <= px <= bx1 and by0 <= py <= by1:
                        # Round only the outer corners of the key.
                        body = cov(rrect_sdf(px, py, bx0, by0, bx1, by1, BR))
                        if body > 0.0:
                            break
            if body <= 0.0:
                continue

            d_scr = rrect_sdf(px, py, SCR_X0, SCR_Y0, SCR_X1, SCR_Y1, INNER_R)
            screen = cov(d_scr)
            punch = cov(math.hypot(px - punch_cx, py - punch_cy) - PUNCH_R)

            # Bezel overlay: body minus the screen cutout, punch-hole opaque.
            a = body * (1.0 - screen)
            col = BORDER_HEX if 0.0 <= d_scr <= 2.0 else BEZEL_HEX
            if punch > 0.0:
                # Punch sits on top of the screen area.
                pa = punch * body
                if pa > a:
                    a, col = pa, PUNCH_HEX
                else:
                    a = max(a, pa)
            if a > 0.0:
                frame[i:i + 4] = bytes(col) + bytes((round(a * 255),))

            # Mask: white where the display shows through, punch excluded.
            m = screen * (1.0 - punch)
            if m > 0.0:
                mask[i:i + 4] = b"\xff\xff\xff" + bytes((round(m * 255),))

    write_rgba_png(ASSETS / "android-frame.png", w, h, frame)
    write_rgba_png(ASSETS / "android-screen-mask.png", w, h, mask)

    meta = {
        "frame": "android-frame.png",
        "frame_w": w, "frame_h": h,
        "cut_x": SCR_X0, "cut_y": SCR_Y0,
        "cut_w": SCREEN_W, "cut_h": SCREEN_H,
        "bezel": BEZEL, "inner_r": INNER_R, "outer_r": OUTER_R,
        "punch_r": PUNCH_R,
    }
    (ASSETS / "android-frame-meta.json").write_text(json.dumps(meta, indent=2) + "\n")
    print(json.dumps(meta, indent=2))
    print(f"frame {w}x{h}  screen {SCREEN_W}x{SCREEN_H}  "
          f"aspect {SCREEN_W/SCREEN_H:.5f} (source {1320/2868:.5f})")


if __name__ == "__main__":
    main()
