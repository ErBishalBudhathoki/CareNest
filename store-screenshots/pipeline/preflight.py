#!/usr/bin/env python3
"""Layout preflight for every slide — builds the same HTML as render.py, asks
Chrome for real getBoundingClientRect() values, and asserts the editorial
furniture, copy block, device and footer never collide.

Exports NO PNGs, so it is safe to run before Gate 3 approval. It reuses
render.build_html() so there is exactly one source of truth for the layout.
"""
import base64
import html as html_lib
import json
import pathlib
import re
import shutil
import subprocess
import sys
import tempfile

import render

PIPE = pathlib.Path(__file__).resolve().parent
CHROME = render.CHROME

PROBE = """
<script>
function cnMeasure(){
  var q=function(s){return document.querySelector(s).getBoundingClientRect()};
  var box=function(e){return {t:Math.round(e.top),b:Math.round(e.bottom),l:Math.round(e.left),r:Math.round(e.right)}};
  var h=document.querySelector('h1'), s=document.querySelector('p.sub');
  var dev=document.querySelector('.device')||document.querySelector('.frame');
  var m={mast:box(q('.mast')),h1:box(q('h1')),sub:box(q('p.sub')),device:box(q_dev(dev)),
         frule:box(q('.frule')),footer:box(q('.footer')),
         h1lines:Math.round(q('h1').height/(parseFloat(getComputedStyle(h).fontSize)*1.08)),
         sublines:Math.round(q('p.sub').height/(parseFloat(getComputedStyle(s).fontSize)*1.35))};
  function q_dev(d){return d.getBoundingClientRect()}
  document.title='CNMETRICS'+JSON.stringify(m);
}
if(document.fonts&&document.fonts.ready){document.fonts.ready.then(cnMeasure)}else{cnMeasure()}
window.addEventListener('load',cnMeasure);
</script>
"""


def measure(slide, plat, font_b64, assets, total):
    meta, ameta, frame_b64, mask_b64, aframe_b64, amask_b64 = assets
    src = render.ROOT / ".maestro/screenshots/screenshots" / slide["image"]
    doc, _ = render.build_html(
        slide, plat, font_b64,
        base64.b64encode(src.read_bytes()).decode("ascii"),
        meta, frame_b64, mask_b64, total,
        ameta, aframe_b64, amask_b64,
    )
    doc = doc.replace("</body>", PROBE + "</body>")
    p = render.PLATFORMS[plat]
    tmp = pathlib.Path(tempfile.mkdtemp(prefix="cn-preflight-"))
    try:
        f = tmp / "probe.html"
        f.write_text(doc, encoding="utf-8")
        cmd = [
            CHROME, "--headless=new", "--disable-gpu", "--no-sandbox",
            "--disable-dev-shm-usage", "--disable-breakpad", "--disable-crash-reporter",
            "--hide-scrollbars", "--no-first-run", "--disable-extensions",
            "--disable-background-networking", "--allow-file-access-from-files",
            "--force-device-scale-factor=1",
            f"--user-data-dir={tmp / 'profile'}",
            f"--window-size={p['W']},{p['H']}", "--dump-dom", f.as_uri(),
        ]
        r = subprocess.run(cmd, capture_output=True, text=True, timeout=120)
        # Chrome's --dump-dom HTML-escapes the title, so &quot; must be undone.
        m = re.search(r"CNMETRICS(.*?)</title>", r.stdout, re.S)
        if not m:
            raise RuntimeError(f"no metrics returned for {plat} {slide['number']}")
        return json.loads(html_lib.unescape(m.group(1)))
    finally:
        shutil.rmtree(tmp, ignore_errors=True)


def main():
    import argparse
    ap = argparse.ArgumentParser()
    ap.add_argument("--config", default="slides.json",
                    help="slide config filename inside pipeline/ (default slides.json)")
    args = ap.parse_args()
    cfg = json.loads((PIPE / args.config).read_text())
    total = int(cfg.get("total", len(cfg["slides"])))
    font_b64 = base64.b64encode((PIPE / "fonts" / "Inter-latin.woff2").read_bytes()).decode("ascii")
    meta, ameta = render.load_assets()
    assets = (
        meta, ameta,
        base64.b64encode((render.ASSETS / meta["frame"]).read_bytes()).decode("ascii"),
        base64.b64encode((render.ASSETS / "iphone-screen-mask.png").read_bytes()).decode("ascii"),
        base64.b64encode((render.ASSETS / ameta["frame"]).read_bytes()).decode("ascii"),
        base64.b64encode((render.ASSETS / "android-screen-mask.png").read_bytes()).decode("ascii"),
    )
    failures, rows = [], []
    for s in cfg["slides"]:
        for plat in ("ios", "android"):
            m = measure(s, plat, font_b64, assets, total)
            p = render.PLATFORMS[plat]
            checks = {
                "masthead >= 7% top": m["mast"]["t"] >= round(p["H"] * 0.07),
                "no masthead/copy overlap": m["mast"]["b"] <= m["h1"]["t"],
                "no copy/device overlap": m["sub"]["b"] < m["device"]["t"],
                "no device/footer-rule overlap": m["device"]["b"] < m["frule"]["t"],
                "no footer-rule/footer overlap": m["frule"]["t"] < m["footer"]["t"],
                "headline <= 2 lines": m["h1lines"] <= 2,
                "copy inside horizontal padding": m["h1"]["l"] >= p["pad"] and m["sub"]["r"] <= p["W"] - p["pad"],
                "masthead inside padding": m["mast"]["l"] >= p["pad"] and m["mast"]["r"] <= p["W"] - p["pad"],
            }
            bad = [k for k, v in checks.items() if not v]
            if bad:
                failures.append((s["number"], plat, bad, m))
            rows.append((s["number"], plat, m, ",".join(bad) if bad else "PASS"))

    print("| Slide | Platform | Headline lines | Subline lines | Copy bottom | Device top | Device bottom | Footer rule | Result |")
    print("|---|---|---|---|---|---|---|---|---|")
    for num, plat, m, status in rows:
        print(f"| {num} | {plat} | {m['h1lines']} | {m['sublines']} | "
              f"{m['sub']['b']} | {m['device']['t']} | {m['device']['b']} | "
              f"{m['frule']['t']} | {status} |")
    print()
    if failures:
        for num, plat, bad, m in failures:
            print(f"FAIL {num}/{plat}: {bad}  metrics={json.dumps(m)}")
        sys.exit(1)
    print(f"{len(rows)}/{len(rows)} slide/platform layouts passed.")


if __name__ == "__main__":
    main()
