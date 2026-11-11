#!/usr/bin/env python3
"""Deterministic CareNest store-screenshot renderer (HTML/CSS -> PNG via headless Chrome).

Every generated HTML is fully self-contained: the Inter woff2, the source app
screenshot, the Screeny iPhone frame and its derived screen mask are inlined as
base64 data URIs, so there are no network or file loads and no render-timing
races. The source PNG is always displayed at object-fit:contain (never
redrawn, never resized on disk) at deviceScaleFactor 1.

Placement note: a capture may declare `safe_top` (a fraction of screen height).
Captures whose status bar sits only ~0.7% below the top edge get their clock
clipped by the real frame's squircle corner, and their appbar crowds the
Dynamic Island / punch hole. `safe_top` shifts that capture down by a flat band
sampled from its own header colour, so the status bar and appbar line up with
the approved captures (which sit at ~2.2-2.6%). The equal trim at the bottom is
a viewport clip in the empty home-indicator zone; no source pixel is edited.

iOS uses a real iPhone 18 Pro Max frame asset (screeny-iphone-frames/). Its
display cutout is exactly 1320x2868, i.e. 1:1 with the App Store 6.9" slot and
with the CareNest source captures. A pixel-exact alpha mask derived from that
frame clips the screenshot to the real squircle, so zero corner bleed is
possible without touching a single source pixel. Android uses its own real
device frame asset plus the same derived-mask technique, so an iPhone frame
never appears in a Google Play listing. The original flat 2D punch-hole frame
is still reproducible with --android-frame legacy.

Editorial furniture (masthead kicker, terminal rule, geometric brand markers,
index badge, progress strip, footer keyline) is ported as pure CSS from the
Google Stitch "CareNest Editorial Asset Sheet" generated against the
Neo-Bauhaus Industrial design system. Stitch's monospace label font is mapped
to Inter with wide tracking so the whole composition still uses exactly one
sans-serif family. No gradients, blurs, shadows, glows or rounded decorative
geometry; every asset is a flat solid fill with a 2px hard black keyline.

Usage:
    python3 render.py --only 01     # Gate 2: prototype only
    python3 render.py               # Gate 3: all slides, both platforms
"""
import argparse
import base64
import html
import json
import pathlib
import shutil
import struct
import subprocess
import tempfile
import zlib

PIPE = pathlib.Path(__file__).resolve().parent
ROOT = PIPE.parents[1]
ASSETS = PIPE / "assets"
CHROME = "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"

# Half-open geometry: all values are exact CSS pixels at deviceScaleFactor 1.
# `deco` holds the Stitch asset dimensions; iOS is the 1:1 reference and the
# Android numbers are hand-tuned (not proportionally scaled) because its canvas
# is 9:16 rather than 6.9" tall.
PLATFORMS = {
    "ios": {
        "W": 1320, "H": 2868,
        "pad": 106,          # >= 8% of 1320 (105.6)
        "top": 202,          # >= 7% of 2868 (200.8)
        "frame_ratio": 0.72,  # inside the mandated 72%-78% band
        "bottom_ratio": 0.05,
        "device": "iphone-frame",
        "head_fs": 98,
        "sub_fs": 40,
        "gap": 22,
        "deco": {
            "mast_h": 56, "mast_gap": 40,
            "kick_fs": 23, "kick_pad": 18,
            "mark_d": 26, "mark_bar_h": 10, "mark_gap": 12, "term": 13,
            "foot_bottom": 40, "foot_h": 56, "frule_gap": 16,
            "fbadge": 56, "fbadge_fs": 26, "fbadge_sm": 10,
            "fword_ml": 22, "foot_fs": 21,
            "seg_w": 32, "strip_h": 16,
        },
    },
    "android": {
        "W": 1080, "H": 1920,
        "pad": 88,           # >= 8% of 1080 (86.4)
        "top": 136,          # >= 7% of 1920 (134.4)
        "frame_ratio": 0.72,  # inside the mandated 72%-78% band
        "bottom_ratio": 0.05,
        "frame": "device",   # "device" = real frame asset, "legacy" = flat CSS
        "legacy": {          # geometry for the original flat 2D frame
            "bezel": 12, "inner_r": 76,
        },
        "head_fs": 64,
        "sub_fs": 27,
        "gap": 14,
        "deco": {
            "mast_h": 40, "mast_gap": 24,
            "kick_fs": 15, "kick_pad": 12,
            "mark_d": 18, "mark_bar_h": 7, "mark_gap": 8, "term": 9,
            "foot_bottom": 24, "foot_h": 40, "frule_gap": 12,
            "fbadge": 40, "fbadge_fs": 19, "fbadge_sm": 8,
            "fword_ml": 14, "foot_fs": 14,
            "seg_w": 20, "strip_h": 12,
        },
    },
}

# Native aspect of the CareNest phone captures (1320 x 2868). All raw sources
# are within 0.45-0.463, so object-fit:contain leaves at most a few px of
# bezel-coloured letterboxing and never crops a single source pixel.
ASPECT = 1320 / 2868

# Status-bar re-layout (`status_fix` on a slide). Measured source-space bands of
# the Android status glyphs in the 1320x2868 SIL/NDIS captures: clock x=19..115,
# tray x=946..1214, all within y=20..68. Expressed as fractions so other source
# resolutions would still work. The clock is ~1.5% from the left edge while the
# tray ends ~8% short of the right; the approved captures sit at ~9.5% / ~5.9%.
SB_Y0_FRAC, SB_Y1_FRAC = 6 / 2868, 82 / 2868
SB_CLOCK_X0_FRAC, SB_CLOCK_X1_FRAC = 0.0, 175 / 1320
SB_TRAY_X0_FRAC, SB_TRAY_X1_FRAC = 895 / 1320, 1.0
SB_CLOCK_SHIFT_FRAC = 0.0792   # of screen width -> +72px iOS / +49px Android
SB_TRAY_SHIFT_FRAC = 0.0223    # of screen width -> +20px iOS / +14px Android

BG = "#FFF9E6"
INK = "#1A1A1A"
BEZEL = "#18181B"
INNER_BORDER = "#27272A"

# CareNest / Stitch brand accents. Used only as small flat fills with hard
# black keylines; all TEXT stays #1A1A1A (16.53:1 on cream, WCAG AAA).
YELLOW = "#FFC300"
TEAL = "#028090"
RED = "#E63946"
BLUE = "#1D4ED8"

TEMPLATE = """<!doctype html>
<html lang="en"><head><meta charset="utf-8"><title>@@SLUG@@</title>
<style>
@font-face{font-family:'InterLocal';src:url(data:font/woff2;base64,@@FONT@@) format('woff2');font-weight:100 900;font-style:normal;font-display:block}
*{margin:0;padding:0;box-sizing:border-box}
html,body{width:@@W@@px;height:@@H@@px;overflow:hidden;background:@@BG@@}
body{position:relative;font-family:'InterLocal',-apple-system,system-ui,sans-serif;color:@@INK@@;-webkit-font-smoothing:antialiased}

/* --- Stitch editorial assets: flat, zero-radius, 2px hard keylines ------ */
.mast{position:absolute;left:@@PAD@@px;right:@@PAD@@px;top:@@TOP@@px;height:@@MASTH@@px;
  display:flex;align-items:center;gap:28px}
.kicker{display:inline-flex;align-items:center;height:@@MASTH@@px;padding:0 @@KICKPAD@@px;
  border:2px solid @@INK@@;background:@@BG@@;font-size:@@KICKFS@@px;font-weight:800;
  letter-spacing:0.18em;text-transform:uppercase;color:@@INK@@;white-space:nowrap;flex:none}
.terminal-rule{flex:1;display:flex;align-items:center;min-width:0}
.terminal-rule::before{content:"";flex:1;height:3px;background:@@INK@@}
.terminal-rule::after{content:"";width:@@TERM@@px;height:@@TERM@@px;background:@@INK@@;flex:none}
.marks{display:flex;align-items:center;gap:@@MARKGAP@@px;flex:none}
.mk{width:@@MARKD@@px;height:@@MARKD@@px;border:2px solid @@INK@@;flex:none}
.mk.sq{background:@@YELLOW@@}
.mk.cir{background:@@TEAL@@;border-radius:50%}
.mk.bar{height:@@MARKBARH@@px;background:@@RED@@}
.mk.arc{background:@@BLUE@@;border-top-left-radius:@@MARKD@@px}
.frule{position:absolute;left:@@PAD@@px;right:@@PAD@@px;top:@@FRULETOP@@px;height:2px;background:@@INK@@}
.footer{position:absolute;left:@@PAD@@px;right:@@PAD@@px;bottom:@@FOOTBOTTOM@@px;
  height:@@FOOTH@@px;display:flex;align-items:center;justify-content:space-between}
.fbadge{width:@@FBADGE@@px;height:@@FBADGE@@px;background:@@YELLOW@@;border:2px solid @@INK@@;
  display:flex;flex-direction:column;align-items:center;justify-content:center;flex:none;color:@@INK@@;line-height:1}
.fbadge b{font-size:@@FBADGEFS@@px;font-weight:800;letter-spacing:-0.04em}
.fbadge span{font-size:@@FBADGESM@@px;font-weight:700;letter-spacing:0.12em;margin-top:3px}
.fword{flex:1;margin-left:@@FWORDM@@px;font-size:@@FOOTFS@@px;font-weight:700;
  letter-spacing:0.18em;text-transform:uppercase;color:@@INK@@;white-space:nowrap}
.strip{display:flex;flex:none;border:2px solid @@INK@@;height:@@STRIPH@@px}
.strip i{display:block;width:@@SEGW@@px;border-right:2px solid @@INK@@}
.strip i:last-child{border-right:0}
.strip i.on{background:@@YELLOW@@}

/* --- copy --------------------------------------------------------------- */
.copy{position:absolute;left:@@PAD@@px;right:@@PAD@@px;top:@@COPYTOP@@px;text-align:left}
h1{font-size:@@HEADFS@@px;font-weight:800;line-height:1.08;letter-spacing:-0.025em;text-wrap:balance;color:@@INK@@;margin:0;max-width:82%}
p.sub{margin-top:@@GAP@@px;font-size:@@SUBFS@@px;font-weight:500;line-height:1.35;letter-spacing:-0.01em;opacity:0.82;color:@@INK@@;text-wrap:balance}

/* --- safe-area placement band (flat fill sampled from the source) ------ */
/* Some captures put their status bar only ~0.8% below the top edge. The real
   device frames have a squircle corner (and, on iPhone, a Dynamic Island), so
   placing such a capture flush at the cutout top clips the clock and crowds the
   appbar under the island. `safe_top` shifts the whole capture down by a small
   flat band filled with the capture's own header colour; the trim at the bottom
   falls in the empty home-indicator zone. No source pixel is edited. */
.band{position:absolute;left:@@BANDLEFT@@;top:@@BANDTOP@@;width:@@BANDW@@;height:@@BANDH@@;
  background:@@BANDCOLOR@@;display:@@BANDDISPLAY@@}
@@SBCSS@@

/* --- real iPhone frame (iOS only) -------------------------------------- */
.device{position:absolute;left:50%;bottom:@@BOTTOM@@px;transform:translateX(-50%);
  width:@@DW@@px;height:@@DH@@px}
.shot{position:absolute;inset:0;background:#000000;
  -webkit-mask-image:url("data:image/png;base64,@@MASKB64@@");
  -webkit-mask-size:100% 100%;-webkit-mask-repeat:no-repeat;
  mask-image:url("data:image/png;base64,@@MASKB64@@");
  mask-size:100% 100%;mask-repeat:no-repeat}
.shot img{position:absolute;display:block;left:@@CX@@px;top:@@IMGTOP@@px;
  width:@@CW@@px;height:@@CH@@px;object-fit:contain}
.bezel{position:absolute;inset:0;display:block;width:100%;height:100%;pointer-events:none}

/* --- real Android frame (Android only) --------------------------------- */
.frame{position:absolute;left:50%;bottom:@@BOTTOM@@px;transform:translateX(-50%);
  width:@@FRAMEW@@px;height:@@FRAMEH@@px}
.ascreen{position:absolute;inset:0;background:#000000;
  -webkit-mask-image:url("data:image/png;base64,@@AMASKB64@@");
  -webkit-mask-size:100% 100%;-webkit-mask-repeat:no-repeat;
  mask-image:url("data:image/png;base64,@@AMASKB64@@");
  mask-size:100% 100%;mask-repeat:no-repeat}
.ascreen img{position:absolute;display:block;left:@@ACX@@px;top:@@AIMGTOP@@px;
  width:@@ACW@@px;height:@@ACH@@px;object-fit:contain}
.abezel{position:absolute;inset:0;display:block;width:100%;height:100%;pointer-events:none}

/* --- legacy flat 2D Android frame (original design) -------------------- */
.legacy{position:absolute;left:50%;bottom:@@BOTTOM@@px;transform:translateX(-50%);
  width:@@FRAMEW@@px;height:@@FRAMEH@@px;background:@@BEZEL@@;
  border:2px solid @@INNERBORDER@@;border-radius:@@OUTERR@@px;padding:@@PADDING@@px;
  overflow:hidden}
.legacy .screen{position:relative;width:100%;height:100%;border-radius:@@INNERR@@px;
  overflow:hidden;background:@@BEZEL@@}
.legacy .screen img.main{display:block;position:relative;top:@@BANDH@@;width:100%;height:100%;object-fit:contain;
  border-radius:@@INNERR@@px}
.legacy .punch{position:absolute;left:50%;top:@@PUNCHTOP@@px;transform:translateX(-50%);
  width:@@PUNCHD@@px;height:@@PUNCHD@@px;border-radius:50%;background:#000000;z-index:2}
</style></head><body>
<div class="mast"><div class="kicker">CARENEST / @@LABEL@@</div>
  <div class="terminal-rule"></div>
  <div class="marks"><i class="mk sq"></i><i class="mk cir"></i><i class="mk bar"></i><i class="mk arc"></i></div>
</div>
<div class="copy"><h1>@@HEADLINE@@</h1><p class="sub">@@SUBLINE@@</p></div>
<div class="frule"></div>
<div class="footer"><div class="fbadge"><b>@@NUM@@</b><span>OF @@TOTAL@@</span></div>
  <div class="fword">NDIS CARE OPERATIONS</div>@@STRIP@@</div>
@@DEVICE_MARKUP@@
</body></html>
"""


def png_header(path):
    with open(path, "rb") as f:
        h = f.read(33)
    if h[:8] != b"\x89PNG\r\n\x1a\n":
        raise ValueError(f"not a PNG: {path}")
    w, ht, bd, ct, comp, filt, inter = struct.unpack(">IIBBBBB", h[16:29])
    return w, ht, bd, ct, comp, filt, inter


def ensure_rgb(path):
    """Chrome already writes 8-bit RGB; convert RGBA -> RGB defensively if needed."""
    data = pathlib.Path(path).read_bytes()
    pos, chunks = 8, []
    while pos < len(data):
        ln = struct.unpack(">I", data[pos:pos + 4])[0]
        typ = data[pos + 4:pos + 8]
        chunks.append((typ, data[pos + 8:pos + 8 + ln]))
        pos += 12 + ln
    w, ht, bd, ct, comp, filt, inter = struct.unpack(">IIBBBBB", chunks[0][1])
    if ct == 2:
        return "RGB (already 3-channel)"
    if ct != 6:
        raise ValueError(f"unexpected PNG colour type {ct}")
    assert bd == 8 and comp == 0 and filt == 0 and inter == 0
    raw = zlib.decompress(b"".join(p for t, p in chunks if t == b"IDAT"))
    bpp, stride, out, prev, i = 4, w * 4, bytearray(), bytearray(w * 4), 0
    for _ in range(ht):
        ft, i = raw[i], i + 1
        line = bytearray(raw[i:i + stride]); i += stride
        for x in range(stride):
            a = line[x - bpp] if x >= bpp else 0
            b = prev[x]
            c = prev[x - bpp] if x >= bpp else 0
            if ft == 1:   line[x] = (line[x] + a) & 255
            elif ft == 2: line[x] = (line[x] + b) & 255
            elif ft == 3: line[x] = (line[x] + ((a + b) // 2)) & 255
            elif ft == 4:
                p = a + b - c
                pa, pb, pc = abs(p - a), abs(p - b), abs(p - c)
                pr = a if pa <= pb and pa <= pc else (b if pb <= pc else c)
                line[x] = (line[x] + pr) & 255
        out.append(0)
        for x in range(0, stride, 4):
            out += line[x:x + 3]
        prev = line
    def chunk(typ, payload):
        return struct.pack(">I", len(payload)) + typ + payload + struct.pack(">I", zlib.crc32(typ + payload) & 0xFFFFFFFF)
    new = b"\x89PNG\r\n\x1a\n"
    new += chunk(b"IHDR", struct.pack(">IIBBBBB", w, ht, 8, 2, 0, 0, 0))
    new += chunk(b"IDAT", zlib.compress(bytes(out), 9))
    new += chunk(b"IEND", b"")
    pathlib.Path(path).write_bytes(new)
    return "RGBA -> RGB converted"


def top_strip_color(png_bytes, rows=8, row_start=0):
    """Most common flat colour in a few scanlines of a source capture.

    Used to fill the safe-area band and the status-bar re-layout covers.
    Sampling the middle 40% of each row avoids the Android status-bar glyphs,
    so the result is exactly the appbar's own solid header colour. ``row_start``
    lets callers sample the glyph rows themselves (the dialog capture is dimmed
    there). The PNG is read from memory only; no source file is modified.
    """
    pos, idat, w, ht, bd, ct, inter = 8, b"", 0, 0, 0, 0, 0
    while pos < len(png_bytes):
        ln = struct.unpack(">I", png_bytes[pos:pos + 4])[0]
        typ = png_bytes[pos + 4:pos + 8]
        if typ == b"IHDR":
            w, ht, bd, ct, _, _, inter = struct.unpack(
                ">IIBBBBB", png_bytes[pos + 8:pos + 21]
            )
        elif typ == b"IDAT":
            idat += png_bytes[pos + 8:pos + 8 + ln]
        pos += 12 + ln
    if ct not in (2, 6) or bd != 8 or inter != 0:
        raise ValueError("safe_top requires an 8-bit non-interlaced RGB/RGBA PNG")
    bpp = 3 if ct == 2 else 4
    stride = w * bpp
    raw = zlib.decompress(idat)
    prev = bytearray(stride)
    i, counts = 0, {}
    for y in range(min(row_start + rows, ht)):
        ft, i = raw[i], i + 1
        line = bytearray(raw[i:i + stride]); i += stride
        for x in range(stride):
            a = line[x - bpp] if x >= bpp else 0
            b = prev[x]
            c = prev[x - bpp] if x >= bpp else 0
            if ft == 1:   line[x] = (line[x] + a) & 255
            elif ft == 2: line[x] = (line[x] + b) & 255
            elif ft == 3: line[x] = (line[x] + ((a + b) // 2)) & 255
            elif ft == 4:
                p = a + b - c
                pa, pb, pc = abs(p - a), abs(p - b), abs(p - c)
                pr = a if pa <= pb and pa <= pc else (b if pb <= pc else c)
                line[x] = (line[x] + pr) & 255
        if y >= row_start:
            for x in range(int(w * 0.30), int(w * 0.70), 3):
                j = x * bpp
                col = (line[j], line[j + 1], line[j + 2])
                counts[col] = counts.get(col, 0) + 1
        prev = line
    r, g, b = max(counts.items(), key=lambda kv: kv[1])[0]
    return f"#{r:02X}{g:02X}{b:02X}"


def png_size(img_b64):
    """Width/height from the first 24 bytes of an inlined PNG (no full decode)."""
    head = base64.b64decode(img_b64[:32])
    return struct.unpack(">II", head[16:24])


def status_bar_layers(img_b64, box_left, box_top, box_w, box_h,
                      src_w, src_h, colour, enabled):
    """Re-lay out the Android status bar using the source's OWN glyph pixels.

    The 600 dpi SIL/NDIS captures put the clock ~1.5% from the left edge and let
    the network/wifi/battery tray stop ~8% short of the right. The approved
    captures sit at ~9.5% / ~5.9%. Because the clock needs a bigger shift than
    the tray, the bar cannot be translated rigidly.

    This returns markup that (1) paints two flat header-colour covers over the
    original clock and tray strips, then (2) draws two clipped copies of the
    SAME inlined PNG, each translated by its own measured amount. No glyph is
    redrawn and no source pixel is modified; only the composite placement
    changes. Everything lives INSIDE the masked screen container, so rounded
    corners, the Dynamic Island and the punch hole stay intact.
    """
    if not enabled:
        return ""
    scale = min(box_w / src_w, box_h / src_h)
    render_w, render_h = src_w * scale, src_h * scale
    off_x = box_left + (box_w - render_w) / 2.0
    off_y = box_top + (box_h - render_h) / 2.0

    def sx(frac):
        return off_x + frac * render_w

    def sy(frac):
        return off_y + frac * render_h

    def px(v):
        return f"{v:.3f}px"

    top = sy(SB_Y0_FRAC)
    height = (SB_Y1_FRAC - SB_Y0_FRAC) * render_h
    clock_x0, clock_x1 = sx(SB_CLOCK_X0_FRAC), sx(SB_CLOCK_X1_FRAC)
    tray_x0, tray_x1 = sx(SB_TRAY_X0_FRAC), sx(SB_TRAY_X1_FRAC)
    clock_shift = SB_CLOCK_SHIFT_FRAC * box_w
    tray_shift = SB_TRAY_SHIFT_FRAC * box_w

    def cover(x0, x1):
        return (f'<div style="position:absolute;left:{px(x0)};top:{px(top)};'
                f'width:{px(x1 - x0)};height:{px(height)};'
                f'background:{colour}"></div>')

    def strip(x0, x1, shift):
        # clip-path is in the img element's local box; convert device coords.
        left_inset = x0 - box_left
        right_inset = box_w - (x1 - box_left)
        top_inset = top - box_top
        bottom_inset = box_h - (sy(SB_Y1_FRAC) - box_top)
        return (
            f'<img alt="" src="data:image/png;base64,{img_b64}" '
            f'style="position:absolute;left:{px(box_left)};top:{px(box_top)};'
            f'width:{px(box_w)};height:{px(box_h)};object-fit:contain;'
            f'clip-path:inset({px(top_inset)} {px(right_inset)} '
            f'{px(bottom_inset)} {px(left_inset)});'
            f'transform:translateX({px(shift)})">'
        )

    return (cover(clock_x0, clock_x1) + cover(tray_x0, tray_x1)
            + strip(clock_x0, clock_x1, clock_shift)
            + strip(tray_x0, tray_x1, tray_shift))


def load_assets():
    meta = json.loads((ASSETS / "frame-meta.json").read_text())
    for f in (meta["frame"], "iphone-screen-mask.png"):
        if not (ASSETS / f).exists():
            raise SystemExit(f"missing {ASSETS/f} — run make_frame_asset.py first")
    ameta = json.loads((ASSETS / "android-frame-meta.json").read_text())
    for f in (ameta["frame"], "android-screen-mask.png"):
        if not (ASSETS / f).exists():
            raise SystemExit(f"missing {ASSETS/f} — run make_android_frame.py first")
    return meta, ameta


def build_html(slide, plat, font_b64, img_b64, meta, frame_b64, mask_b64, total,
               ameta=None, aframe_b64="", amask_b64=""):
    p = PLATFORMS[plat]
    d = p["deco"]
    frame_h = round(p["H"] * p["frame_ratio"])
    bottom = round(p["H"] * p["bottom_ratio"])
    num = int(slide["number"])
    safe = float(slide.get("safe_top", 0.0))
    sb_fix = bool(slide.get("status_fix", False))
    raw_png = base64.b64decode(img_b64)
    src_w, src_h = png_size(img_b64)
    band_color = top_strip_color(raw_png) if (safe > 0 or sb_fix) else "#000000"
    # Status-bar covers must use the flat header colour sampled at the GLYPH
    # ROWS, not the very top scanlines (the dialog version is dimmed).
    sb_color = top_strip_color(raw_png, row_start=14, rows=40) if sb_fix else "#000000"

    # Values for both CSS branches are always supplied so no token is left
    # unsubstituted on either platform.
    tokens = {
        "SLUG": slide["slug"], "FONT": font_b64, "IMG": img_b64,
        "W": p["W"], "H": p["H"], "PAD": p["pad"], "TOP": p["top"],
        "HEADFS": p["head_fs"], "SUBFS": p["sub_fs"], "GAP": p["gap"],
        "COPYTOP": p["top"] + d["mast_h"] + d["mast_gap"],
        "BG": BG, "INK": INK, "BEZEL": BEZEL, "INNERBORDER": INNER_BORDER,
        "YELLOW": YELLOW, "TEAL": TEAL, "RED": RED, "BLUE": BLUE,
        "BOTTOM": bottom,
        "FRAMEB64": frame_b64, "MASKB64": mask_b64,
        "AFRAMEB64": aframe_b64,
        "MASTH": d["mast_h"], "KICKFS": d["kick_fs"], "KICKPAD": d["kick_pad"],
        "TERM": d["term"], "MARKD": d["mark_d"], "MARKBARH": d["mark_bar_h"],
        "MARKGAP": d["mark_gap"],
        "FRULETOP": p["H"] - d["foot_bottom"] - d["foot_h"] - d["frule_gap"] - 2,
        "FOOTBOTTOM": d["foot_bottom"], "FOOTH": d["foot_h"],
        "FBADGE": d["fbadge"], "FBADGEFS": d["fbadge_fs"], "FBADGESM": d["fbadge_sm"],
        "FWORDM": d["fword_ml"], "FOOTFS": d["foot_fs"],
        "SEGW": d["seg_w"], "STRIPH": d["strip_h"],
        "NUM": slide["number"], "TOTAL": f"{total:02d}",
        "LABEL": html.escape(slide.get("label", "Operations").upper()),
        "STRIP": '<div class="strip">' + "".join(
            '<i class="on"></i>' if i == num else '<i></i>' for i in range(1, total + 1)
        ) + "</div>",
        "DW": 0, "DH": 0, "CX": 0, "CY": 0, "CW": 0, "CH": 0,
        "FRAMEW": 0, "FRAMEH": 0, "OUTERR": 0, "INNERR": 0,
        "PADDING": 0, "PUNCHD": 0, "PUNCHTOP": 0,
        "ACX": 0, "ACY": 0, "ACW": 0, "ACH": 0,
        "AMASKB64": amask_b64,
        "BANDLEFT": "0", "BANDTOP": "0", "BANDW": "100%", "BANDH": "0px",
        "BANDCOLOR": band_color, "BANDDISPLAY": "none",
        "IMGTOP": 0, "AIMGTOP": 0,
        "SBCOLOR": sb_color, "SBCSS": "", "SBHTML": "",
        "HEADLINE": html.escape(slide["headline"]),
        "SUBLINE": html.escape(slide["subline"]),
    }

    if plat == "ios":
        # Scale the whole frame asset so its height is exactly 72% of canvas.
        s = frame_h / meta["frame_h"]
        dw, dh = round(meta["frame_w"] * s), round(meta["frame_h"] * s)
        cx, cy = round(meta["cut_x"] * s), round(meta["cut_y"] * s)
        cw, ch = round(meta["cut_w"] * s), round(meta["cut_h"] * s)
        band = round(safe * ch)
        tokens.update(DW=dw, DH=dh, CX=cx, CY=cy, CW=cw, CH=ch,
                      BANDLEFT=f"{cx}px", BANDTOP=f"{cy}px", BANDW=f"{cw}px",
                      BANDH=f"{band}px", BANDDISPLAY="block" if band else "none",
                      IMGTOP=cy + band)
        tokens["SBHTML"] = status_bar_layers(
            img_b64, cx, cy + band, cw, ch, src_w, src_h, sb_color, sb_fix)
        tokens["DEVICE_MARKUP"] = (
            '<div class="device">'
            '<div class="shot"><div class="band"></div>'
            '<img src="data:image/png;base64,@@IMG@@" alt="">@@SBHTML@@</div>'
            '<img class="bezel" src="data:image/png;base64,@@FRAMEB64@@" alt="">'
            '</div>'
        )
        info = {
            "frame_w": dw, "frame_h": dh, "device": "iphone-frame",
            "inner_r": meta["inner_r"], "bezel": meta["bezel"],
            "outer_r": meta["outer_r"],
            "safe_top_px": band,
            "note": f"real frame {meta['frame']} scaled {s:.4f}; cutout {meta['cut_w']}x{meta['cut_h']}",
        }
    else:
        if p.get("frame") == "legacy":
            # Original flat 2D frame, preserved so the pre-existing render can
            # be reproduced byte-for-byte alongside the new device-frame set.
            lg = p["legacy"]
            bezel, inner_r = lg["bezel"], lg["inner_r"]
            inner_h = frame_h - 2 * bezel
            inner_w = round(inner_h * ASPECT)
            frame_w = inner_w + 2 * bezel
            outer_r = inner_r + bezel             # concentric radius rule
            padding = bezel - 2                   # 2px border + padding == bezel
            tokens.update(FRAMEW=frame_w, FRAMEH=frame_h, OUTERR=outer_r,
                          INNERR=inner_r, PADDING=padding,
                          PUNCHD=round(0.030 * inner_w),
                          PUNCHTOP=round(0.018 * inner_h))
            tokens.update(BANDLEFT="0", BANDTOP="0", BANDW="100%",
                          BANDH=f"{round(safe * inner_h)}px",
                          BANDDISPLAY="block" if safe > 0 else "none")
            tokens["SBHTML"] = status_bar_layers(
                img_b64, 0, round(safe * inner_h), inner_w, inner_h,
                src_w, src_h, sb_color, sb_fix)
            tokens["DEVICE_MARKUP"] = (
                '<div class="legacy"><div class="screen"><div class="band"></div>'
                '<img class="main" src="data:image/png;base64,@@IMG@@" alt="">@@SBHTML@@'
                '<div class="punch"></div></div></div>'
            )
            info = {
                "frame_w": frame_w, "frame_h": frame_h, "device": "android-legacy",
                "inner_r": inner_r, "bezel": bezel, "outer_r": outer_r,
                "safe_top_px": round(safe * inner_h),
                "note": "flat 2D punch-hole frame (original design)",
            }
        else:
            # Scale the whole frame asset so its height is exactly 72% of canvas,
            # then place the screen cutout at its measured offset inside it.
            s = frame_h / ameta["frame_h"]
            fw, fh = round(ameta["frame_w"] * s), round(ameta["frame_h"] * s)
            acx, acy = round(ameta["cut_x"] * s), round(ameta["cut_y"] * s)
            acw, ach = round(ameta["cut_w"] * s), round(ameta["cut_h"] * s)
            band = round(safe * ach)
            tokens.update(FRAMEW=fw, FRAMEH=fh, ACX=acx, ACY=acy, ACW=acw, ACH=ach,
                          BANDLEFT=f"{acx}px", BANDTOP=f"{acy}px", BANDW=f"{acw}px",
                          BANDH=f"{band}px", BANDDISPLAY="block" if band else "none",
                          AIMGTOP=acy + band)
            tokens["SBHTML"] = status_bar_layers(
                img_b64, acx, acy + band, acw, ach, src_w, src_h, sb_color, sb_fix)
            tokens["DEVICE_MARKUP"] = (
                '<div class="frame">'
                '<div class="ascreen"><div class="band"></div>'
                '<img src="data:image/png;base64,@@IMG@@" alt="">@@SBHTML@@</div>'
                '<img class="abezel" src="data:image/png;base64,@@AFRAMEB64@@" alt="">'
                '</div>'
            )
            info = {
                "frame_w": fw, "frame_h": fh, "device": "android-frame",
                "inner_r": round(ameta["inner_r"] * s), "bezel": round(ameta["bezel"] * s),
                "outer_r": round(ameta["outer_r"] * s),
                "safe_top_px": band,
                "note": f"real frame {ameta['frame']} scaled {s:.4f}; "
                        f"cutout {ameta['cut_w']}x{ameta['cut_h']}",
            }

    out = TEMPLATE
    # DEVICE_MARKUP itself contains IMG/FRAMEB64 tokens; expand it first.
    markup = tokens.pop("DEVICE_MARKUP")
    out = out.replace("@@DEVICE_MARKUP@@", markup)
    for k, v in tokens.items():
        out = out.replace("@@" + k + "@@", str(v))
    assert "@@" not in out, "unreplaced template token"
    return out, info


def render_one(slide, plat, font_b64, cfg, assets, total, out_root=None):
    meta, ameta, frame_b64, mask_b64, aframe_b64, amask_b64 = assets
    src = ROOT / cfg["source_dir"] / slide["image"]
    img_b64 = base64.b64encode(src.read_bytes()).decode("ascii")
    doc, info = build_html(slide, plat, font_b64, img_b64, meta, frame_b64, mask_b64, total,
                           ameta, aframe_b64, amask_b64)
    p = PLATFORMS[plat]
    out_dir = (out_root or (ROOT / "store-screenshots")) / plat
    out_dir.mkdir(parents=True, exist_ok=True)
    out_png = out_dir / f"{slide['number']}-{slide['slug']}.png"

    tmp = pathlib.Path(tempfile.mkdtemp(prefix="cn-render-"))
    try:
        tmp_html = tmp / "slide.html"
        tmp_html.write_text(doc, encoding="utf-8")
        cmd = [
            CHROME, "--headless=new", "--disable-gpu", "--no-sandbox",
            "--disable-dev-shm-usage", "--disable-breakpad", "--disable-crash-reporter",
            "--hide-scrollbars", "--no-first-run", "--disable-extensions",
            "--disable-background-networking", "--allow-file-access-from-files",
            "--force-device-scale-factor=1", "--force-color-profile=srgb",
            f"--user-data-dir={tmp / 'profile'}",
            f"--window-size={p['W']},{p['H']}",
            f"--screenshot={out_png}", tmp_html.as_uri(),
        ]
        r = subprocess.run(cmd, capture_output=True, text=True, timeout=120)
        if r.returncode != 0 or not out_png.exists():
            raise RuntimeError(f"Chrome failed ({r.returncode}): {r.stderr[-800:]}")
        conv = ensure_rgb(out_png)
        w, ht, bd, ct, *_ = png_header(out_png)
        if (w, ht) != (p["W"], p["H"]) or ct != 2 or bd != 8:
            raise RuntimeError(f"bad output header {w}x{ht} bd={bd} ct={ct}")
        print(f"  {plat:8s} {out_png.name:34s} {w}x{ht} RGB  "
              f"frame {info['frame_w']}x{info['frame_h']} "
              f"@bottom {round(p['H']*p['bottom_ratio'])}px  "
              f"radii inner {info['inner_r']} + bezel {info['bezel']} = outer {info['outer_r']}  "
              f"device={info['device']}  [{conv}]  "
              f"{out_png.stat().st_size/1024:.0f} KB", flush=True)
        print(f"           {info['note']}", flush=True)
    finally:
        shutil.rmtree(tmp, ignore_errors=True)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--only", help="render only this slide number, e.g. 01")
    ap.add_argument("--android-frame", choices=["device", "legacy"], default="device",
                    help="Android frame style: real device asset (default) or the "
                         "original flat 2D frame")
    ap.add_argument("--out", help="output dir override (default store-screenshots/<platform>)")
    ap.add_argument("--config", default="slides.json",
                    help="slide config filename inside pipeline/ (default slides.json)")
    args = ap.parse_args()
    PLATFORMS["android"]["frame"] = args.android_frame
    cfg = json.loads((PIPE / args.config).read_text())
    total = int(cfg.get("total", len(cfg["slides"])))
    font_b64 = base64.b64encode((PIPE / "fonts" / "Inter-latin.woff2").read_bytes()).decode("ascii")
    meta, ameta = load_assets()
    assets = (
        meta, ameta,
        base64.b64encode((ASSETS / meta["frame"]).read_bytes()).decode("ascii"),
        base64.b64encode((ASSETS / "iphone-screen-mask.png").read_bytes()).decode("ascii"),
        base64.b64encode((ASSETS / ameta["frame"]).read_bytes()).decode("ascii"),
        base64.b64encode((ASSETS / "android-screen-mask.png").read_bytes()).decode("ascii"),
    )
    slides = [s for s in cfg["slides"] if not args.only or s["number"] == args.only]
    if not slides:
        raise SystemExit(f"no slide matches --only {args.only!r}")
    out_root = ROOT / args.out if args.out else None
    for s in slides:
        assert len(s["headline"].split()) <= 6, f"headline too long: {s['headline']}"
        assert len(s["subline"].split()) <= 10, f"subline too long: {s['subline']}"
        print(f"slide {s['number']} {s['slug']}: {s['image']}  [{s.get('label','')}]")
        for plat in ("ios", "android"):
            render_one(s, plat, font_b64, cfg, assets, total, out_root)
    print(f"rendered {len(slides)} slide(s) x 2 platforms")


if __name__ == "__main__":
    main()
