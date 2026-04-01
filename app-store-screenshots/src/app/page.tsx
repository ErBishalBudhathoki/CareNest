"use client";

import { toPng } from "html-to-image";
import { useEffect, useRef, useState } from "react";
import type { CSSProperties, ReactNode } from "react";

const DESIGN_WIDTH = 1320;
const DESIGN_HEIGHT = 2868;

const IPHONE_SIZES = [
  { label: '6.9"', w: 1320, h: 2868 },
  { label: '6.5"', w: 1284, h: 2778 },
  { label: '6.3"', w: 1206, h: 2622 },
  { label: '6.1"', w: 1125, h: 2436 },
] as const;

const LOCALES = ["en"] as const;
type Locale = (typeof LOCALES)[number];

const THEMES = {
  tide: {
    id: "tide",
    name: "Tide",
    bg: "#edf6f5",
    bgStrong: "#0f3652",
    fg: "#102132",
    fgInverse: "#f7fbff",
    accent: "#45b9ba",
    accentSoft: "#bfeee7",
    accentWarm: "#f5ead2",
    line: "rgba(16, 33, 50, 0.12)",
    shadow: "rgba(7, 31, 48, 0.18)",
  },
  midnight: {
    id: "midnight",
    name: "Midnight",
    bg: "#091a2d",
    bgStrong: "#06111d",
    fg: "#f2f8ff",
    fgInverse: "#f2f8ff",
    accent: "#8be0da",
    accentSoft: "#1d5d74",
    accentWarm: "#f4e5c6",
    line: "rgba(242, 248, 255, 0.12)",
    shadow: "rgba(0, 0, 0, 0.3)",
  },
  linen: {
    id: "linen",
    name: "Linen",
    bg: "#f8f1e5",
    bgStrong: "#143754",
    fg: "#1f2d39",
    fgInverse: "#f8fbff",
    accent: "#2ea4a8",
    accentSoft: "#d7efea",
    accentWarm: "#fff4dd",
    line: "rgba(31, 45, 57, 0.1)",
    shadow: "rgba(15, 32, 50, 0.14)",
  },
} as const;

type ThemeId = keyof typeof THEMES;
type Theme = (typeof THEMES)[ThemeId];

const COPY_BY_LOCALE: Record<
  Locale,
  {
    badge: string;
    note: string;
  }
> = {
  en: {
    badge: "CareNest",
    note: "Replace /public/app-icon.png with the attached final logo before export.",
  },
};

const MK_W = 1022;
const MK_H = 2082;
const SC_L = (52 / MK_W) * 100;
const SC_T = (46 / MK_H) * 100;
const SC_W = (918 / MK_W) * 100;
const SC_H = (1990 / MK_H) * 100;
const SC_RX = (126 / 918) * 100;
const SC_RY = (126 / 1990) * 100;

type SlideThemeMode = "light" | "dark";
type Slide = {
  id: string;
  filename: string;
  kicker: string;
  title: ReactNode;
  body: string;
  screenshot: string;
  screenshotAlt: string;
  chips: string[];
  mode: SlideThemeMode;
  layout: "hero" | "split" | "stack" | "panel" | "closing";
  statLabel?: string;
  statValue?: string;
};

const SLIDES: Slide[] = [
  {
    id: "01-admin-dashboard",
    filename: "01-admin-dashboard",
    kicker: "Admin dashboard",
    title: (
      <>
        Run care
        <br />
        in one view
      </>
    ),
    body:
      "See owner tools, organization controls, and team actions from one calm control center.",
    screenshot: "/screenshots/admin-dashboard.png",
    screenshotAlt: "Admin dashboard tools in the CareNest app",
    chips: ["Owner tools", "Security view", "Pricing insights"],
    mode: "light",
    layout: "hero",
    statLabel: "Shift control",
    statValue: "Always visible",
  },
  {
    id: "02-employee-dashboard",
    filename: "02-employee-dashboard",
    kicker: "Employee routing",
    title: (
      <>
        Place the right
        <br />
        worker fast
      </>
    ),
    body:
      "Search your team, open staff records quickly, and keep every assignment moving without delay.",
    screenshot: "/screenshots/employee-dashboard.png",
    screenshotAlt: "Employee list and search tools in the CareNest app",
    chips: ["Fast search", "Shift handoff", "Cleaner staffing"],
    mode: "dark",
    layout: "split",
    statLabel: "Assignment flow",
    statValue: "Search to act",
  },
  {
    id: "03-client-dashboard",
    filename: "03-client-dashboard",
    kicker: "Client dashboard",
    title: (
      <>
        Clients see
        <br />
        what matters
      </>
    ),
    body:
      "Appointments, live worker visibility, and secure messaging stay together in one clear home screen.",
    screenshot: "/screenshots/client-dashboard.png",
    screenshotAlt: "Client dashboard with messaging and tracking in the CareNest app",
    chips: ["Live tracking", "Secure chat", "Service feedback"],
    mode: "light",
    layout: "stack",
    statLabel: "Client trust",
    statValue: "Updates stay clear",
  },
  {
    id: "04-invoice-list",
    filename: "04-invoice-generation",
    kicker: "Invoice generation",
    title: (
      <>
        Send invoices
        <br />
        without lag
      </>
    ),
    body:
      "Generated invoices stay readable at a glance, so teams can review status and payment progress fast.",
    screenshot: "/screenshots/invoice-list.png",
    screenshotAlt: "Invoice list view in the CareNest app",
    chips: ["Generated invoices", "Status filters", "Clear due dates"],
    mode: "light",
    layout: "panel",
    statLabel: "Invoice status",
    statValue: "Pending to paid",
  },
  {
    id: "05-invoice-detail",
    filename: "05-invoice-detail",
    kicker: "Invoice detail",
    title: (
      <>
        Approve work
        <br />
        with proof
      </>
    ),
    body:
      "Review totals, dates, and actions before approving or disputing each invoice in a few taps.",
    screenshot: "/screenshots/invoice-detail.png",
    screenshotAlt: "Invoice detail actions in the CareNest app",
    chips: ["Approve fast", "Dispute clearly", "Audit-ready detail"],
    mode: "dark",
    layout: "closing",
    statLabel: "Final review",
    statValue: "One-tap actions",
  },
];

function clampTheme(themeId: string | null): ThemeId {
  return themeId === "midnight" || themeId === "linen" ? themeId : "tide";
}

function clampLocale(locale: string | null): Locale {
  return locale === "en" ? locale : "en";
}

function clampSize(size: string | null) {
  return IPHONE_SIZES.find((entry) => entry.label === size) ?? IPHONE_SIZES[0];
}

function downloadDataUrl(filename: string, dataUrl: string) {
  const anchor = document.createElement("a");
  anchor.href = dataUrl;
  anchor.download = filename;
  anchor.click();
}

function Phone({
  src,
  alt,
  className = "",
  style,
}: {
  src: string;
  alt: string;
  className?: string;
  style?: CSSProperties;
}) {
  return (
    <div className={`phone-shell ${className}`} style={style}>
      <img className="phone-mockup" src="/mockup.png" alt="" draggable={false} />
      <div
        className="phone-screen"
        style={{
          left: `${SC_L}%`,
          top: `${SC_T}%`,
          width: `${SC_W}%`,
          height: `${SC_H}%`,
          borderRadius: `${SC_RX}% / ${SC_RY}%`,
        }}
      >
        <img className="phone-screen-image" src={src} alt={alt} draggable={false} />
      </div>
    </div>
  );
}

function ChipRow({
  slide,
  theme,
  inverse = false,
}: {
  slide: Slide;
  theme: Theme;
  inverse?: boolean;
}) {
  return (
    <div className="chip-row">
      {slide.chips.map((chip) => (
        <span
          key={chip}
          className={`chip ${inverse ? "chip-inverse" : ""}`}
          style={{
            borderColor: inverse ? "rgba(247, 251, 255, 0.18)" : theme.line,
            background: inverse ? "rgba(247, 251, 255, 0.08)" : "rgba(255, 255, 255, 0.68)",
            color: inverse ? theme.fgInverse : theme.fg,
          }}
        >
          {chip}
        </span>
      ))}
    </div>
  );
}

function SlideCanvas({
  slide,
  theme,
  locale,
  size,
}: {
  slide: Slide;
  theme: Theme;
  locale: Locale;
  size: (typeof IPHONE_SIZES)[number];
}) {
  const copy = COPY_BY_LOCALE[locale];
  const surfaceClass = slide.mode === "dark" ? "surface-dark" : "surface-light";
  const themeVars = {
    "--canvas-bg": slide.mode === "dark" ? theme.bgStrong : theme.bg,
    "--canvas-fg": slide.mode === "dark" ? theme.fgInverse : theme.fg,
    "--canvas-muted": slide.mode === "dark" ? "rgba(247,251,255,0.76)" : "rgba(16,33,50,0.72)",
    "--canvas-card": slide.mode === "dark" ? "rgba(247,251,255,0.08)" : "rgba(255,255,255,0.72)",
    "--canvas-line": slide.mode === "dark" ? "rgba(247,251,255,0.12)" : theme.line,
    "--canvas-accent": theme.accent,
    "--canvas-accent-soft": theme.accentSoft,
    "--canvas-warm": theme.accentWarm,
    "--canvas-shadow": theme.shadow,
  } as CSSProperties;

  const renderContent = () => {
    if (slide.layout === "hero") {
      return (
        <div className="layout hero-layout">
          <div className="copy-column">
            <BrandHeader copy={copy} theme={theme} inverse={false} />
            <HeadlineBlock slide={slide} />
            <ChipRow slide={slide} theme={theme} />
            <StatCard slide={slide} inverse={false} />
          </div>
          <div className="device-column hero-device-column">
            <GlowOrb className="orb-a" />
            <GlowOrb className="orb-b" />
            <Phone src={slide.screenshot} alt={slide.screenshotAlt} className="hero-phone" />
            <FloatingNote>
              One place for dashboards,
              <br />
              staffing, and billing.
            </FloatingNote>
          </div>
        </div>
      );
    }

    if (slide.layout === "split") {
      return (
        <div className="layout split-layout">
          <div className="device-column split-phone-wrap">
            <GlowOrb className="orb-c" />
            <Phone src={slide.screenshot} alt={slide.screenshotAlt} className="split-phone" />
          </div>
          <div className="copy-column split-copy">
            <BrandHeader copy={copy} theme={theme} inverse />
            <HeadlineBlock slide={slide} inverse />
            <ChipRow slide={slide} theme={theme} inverse />
            <StatCard slide={slide} inverse />
          </div>
        </div>
      );
    }

    if (slide.layout === "stack") {
      return (
        <div className="layout stack-layout">
          <BrandHeader copy={copy} theme={theme} inverse={false} />
          <div className="stack-headline">
            <HeadlineBlock slide={slide} />
          </div>
          <div className={`feature-panel ${surfaceClass}`}>
            <div className="panel-copy">
              <p className="body-copy">{slide.body}</p>
              <ChipRow slide={slide} theme={theme} />
            </div>
            <Phone src={slide.screenshot} alt={slide.screenshotAlt} className="stack-phone" />
          </div>
        </div>
      );
    }

    if (slide.layout === "panel") {
      return (
        <div className="layout panel-layout">
          <div className="panel-left">
            <BrandHeader copy={copy} theme={theme} inverse={false} />
            <HeadlineBlock slide={slide} />
            <p className="body-copy">{slide.body}</p>
            <StatCard slide={slide} inverse={false} />
          </div>
          <div className={`panel-right ${surfaceClass}`}>
            <Phone src={slide.screenshot} alt={slide.screenshotAlt} className="panel-phone" />
            <ChipRow slide={slide} theme={theme} />
          </div>
        </div>
      );
    }

    return (
      <div className="layout closing-layout">
        <div className="closing-top">
          <BrandHeader copy={copy} theme={theme} inverse />
          <HeadlineBlock slide={slide} inverse />
          <p className="body-copy body-copy-inverse">{slide.body}</p>
        </div>
        <div className="closing-bottom">
          <div className="closing-meta">
            <StatCard slide={slide} inverse />
            <ChipRow slide={slide} theme={theme} inverse />
          </div>
          <div className="closing-phone-wrap">
            <GlowOrb className="orb-d" />
            <Phone src={slide.screenshot} alt={slide.screenshotAlt} className="closing-phone" />
          </div>
        </div>
      </div>
    );
  };

  return (
    <section
      className={`slide-canvas ${slide.mode === "dark" ? "canvas-dark" : "canvas-light"}`}
      style={{
        ...themeVars,
        width: size.w,
        height: size.h,
      }}
    >
      <div className="canvas-backdrop">
        <div className="mesh mesh-a" />
        <div className="mesh mesh-b" />
        <div className="mesh mesh-c" />
      </div>
      {renderContent()}
    </section>
  );
}

function BrandHeader({
  copy,
  theme,
  inverse = false,
}: {
  copy: { badge: string; note: string };
  theme: Theme;
  inverse?: boolean;
}) {
  return (
    <div className="brand-header">
      <div
        className="brand-mark"
        style={{
          background: inverse ? "rgba(247, 251, 255, 0.12)" : "rgba(255, 255, 255, 0.72)",
          borderColor: inverse ? "rgba(247, 251, 255, 0.16)" : theme.line,
        }}
      >
        <img src="/app-icon.png" alt="CareNest app icon" />
      </div>
      <div className="brand-copy">
        <span className={`brand-badge ${inverse ? "brand-badge-inverse" : ""}`}>{copy.badge}</span>
        <span className={`brand-note ${inverse ? "brand-note-inverse" : ""}`}>{copy.note}</span>
      </div>
    </div>
  );
}

function HeadlineBlock({ slide, inverse = false }: { slide: Slide; inverse?: boolean }) {
  return (
    <div className="headline-block">
      <span className={`eyebrow ${inverse ? "eyebrow-inverse" : ""}`}>{slide.kicker}</span>
      <h1 className={`headline ${inverse ? "headline-inverse" : ""}`}>{slide.title}</h1>
      <p className={`body-copy ${inverse ? "body-copy-inverse" : ""}`}>{slide.body}</p>
    </div>
  );
}

function StatCard({ slide, inverse = false }: { slide: Slide; inverse?: boolean }) {
  return (
    <div className={`stat-card ${inverse ? "stat-card-inverse" : ""}`}>
      <span className="stat-label">{slide.statLabel}</span>
      <strong className="stat-value">{slide.statValue}</strong>
    </div>
  );
}

function FloatingNote({ children }: { children: ReactNode }) {
  return <div className="floating-note">{children}</div>;
}

function GlowOrb({ className }: { className: string }) {
  return <div className={`glow-orb ${className}`} />;
}

export default function Page() {
  const [themeId, setThemeId] = useState<ThemeId>("tide");
  const [locale, setLocale] = useState<Locale>("en");
  const [selectedSizeLabel, setSelectedSizeLabel] = useState<(typeof IPHONE_SIZES)[number]["label"]>(
    IPHONE_SIZES[0].label
  );
  const [isExporting, setIsExporting] = useState(false);
  const exportRefs = useRef<Array<HTMLDivElement | null>>([]);

  useEffect(() => {
    const searchParams = new URLSearchParams(window.location.search);
    setThemeId(clampTheme(searchParams.get("theme")));
    setLocale(clampLocale(searchParams.get("locale")));
    setSelectedSizeLabel(clampSize(searchParams.get("size")).label);
  }, []);

  const selectedSize = clampSize(selectedSizeLabel);
  const theme = THEMES[themeId];
  const previewScale = 330 / selectedSize.w;

  async function exportSlide(slide: Slide, index: number) {
    const node = exportRefs.current[index];
    if (!node) return;
    const dataUrl = await toPng(node, {
      cacheBust: true,
      pixelRatio: 1,
      canvasWidth: selectedSize.w,
      canvasHeight: selectedSize.h,
    });
    downloadDataUrl(`${slide.filename}-${selectedSize.w}x${selectedSize.h}.png`, dataUrl);
  }

  async function exportAllSlides() {
    setIsExporting(true);
    try {
      for (const [index, slide] of SLIDES.entries()) {
        await exportSlide(slide, index);
      }
    } finally {
      setIsExporting(false);
    }
  }

  return (
    <main className="app-shell">
      <section className="toolbar">
        <div className="toolbar-copy">
          <p className="toolbar-kicker">CareNest App Store set</p>
          <h1>Five slides, one export surface, and a replaceable icon placeholder.</h1>
        </div>

        <div className="toolbar-controls">
          <label>
            Theme
            <select value={themeId} onChange={(event) => setThemeId(event.target.value as ThemeId)}>
              {Object.values(THEMES).map((entry) => (
                <option key={entry.id} value={entry.id}>
                  {entry.name}
                </option>
              ))}
            </select>
          </label>

          <label>
            Locale
            <select value={locale} onChange={(event) => setLocale(event.target.value as Locale)}>
              {LOCALES.map((entry) => (
                <option key={entry} value={entry}>
                  {entry.toUpperCase()}
                </option>
              ))}
            </select>
          </label>

          <label>
            Export size
            <select
              value={selectedSizeLabel}
              onChange={(event) =>
                setSelectedSizeLabel(event.target.value as (typeof IPHONE_SIZES)[number]["label"])
              }
            >
              {IPHONE_SIZES.map((entry) => (
                <option key={entry.label} value={entry.label}>
                  {entry.label} · {entry.w}x{entry.h}
                </option>
              ))}
            </select>
          </label>

          <button type="button" onClick={exportAllSlides} disabled={isExporting}>
            {isExporting ? "Exporting..." : "Export all"}
          </button>
        </div>
      </section>

      <section className="asset-note">
        Using real repo screenshots for admin, employee, client, and invoice flows.
        Replace <code>public/app-icon.png</code> with the attached blue/cream caregiver icon before the final export.
      </section>

      <section className="preview-grid">
        {SLIDES.map((slide, index) => (
          <article key={slide.id} className="preview-card">
            <div className="preview-meta">
              <div>
                <p className="preview-number">
                  {String(index + 1).padStart(2, "0")} · {slide.kicker}
                </p>
                <h2>{slide.filename.replace(/-/g, " ")}</h2>
              </div>
              <button type="button" onClick={() => exportSlide(slide, index)}>
                Export PNG
              </button>
            </div>

            <div className="preview-stage">
              <div
                className="preview-scaled"
                style={{
                  width: selectedSize.w,
                  height: selectedSize.h,
                  transform: `scale(${previewScale})`,
                  transformOrigin: "top left",
                }}
              >
                <SlideCanvas slide={slide} theme={theme} locale={locale} size={selectedSize} />
              </div>
            </div>
          </article>
        ))}
      </section>

      <div className="export-surface" aria-hidden="true">
        {SLIDES.map((slide, index) => (
          <div
            key={slide.id}
            ref={(node) => {
              exportRefs.current[index] = node;
            }}
          >
            <SlideCanvas slide={slide} theme={theme} locale={locale} size={selectedSize} />
          </div>
        ))}
      </div>

      <style jsx global>{`
        * {
          box-sizing: border-box;
        }

        html,
        body {
          margin: 0;
          min-height: 100%;
          background: #08131f;
          color: #eef5fb;
          font-family: "Inter Tight", Inter, ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
        }

        button,
        select {
          font: inherit;
        }

        img {
          max-width: 100%;
        }

        .app-shell {
          min-height: 100vh;
          padding: 32px;
          background:
            radial-gradient(circle at top left, rgba(69, 185, 186, 0.14), transparent 28%),
            radial-gradient(circle at bottom right, rgba(244, 229, 198, 0.14), transparent 30%),
            linear-gradient(180deg, #09131f 0%, #0e1b2b 100%);
        }

        .toolbar {
          display: flex;
          flex-wrap: wrap;
          justify-content: space-between;
          gap: 24px;
          padding: 28px;
          border: 1px solid rgba(255, 255, 255, 0.08);
          border-radius: 28px;
          background: rgba(10, 20, 32, 0.78);
          backdrop-filter: blur(18px);
        }

        .toolbar-copy {
          max-width: 720px;
        }

        .toolbar-kicker,
        .preview-number {
          margin: 0 0 8px;
          text-transform: uppercase;
          letter-spacing: 0.18em;
          font-size: 12px;
          color: rgba(191, 238, 231, 0.82);
        }

        .toolbar h1,
        .preview-meta h2 {
          margin: 0;
          line-height: 1;
          font-size: 32px;
          letter-spacing: -0.05em;
        }

        .toolbar-controls {
          display: flex;
          flex-wrap: wrap;
          align-items: flex-end;
          gap: 16px;
        }

        .toolbar-controls label {
          display: grid;
          gap: 8px;
          font-size: 12px;
          text-transform: uppercase;
          letter-spacing: 0.16em;
          color: rgba(238, 245, 251, 0.72);
        }

        .toolbar-controls select,
        .toolbar-controls button,
        .preview-meta button {
          min-height: 48px;
          padding: 0 16px;
          border-radius: 999px;
          border: 1px solid rgba(255, 255, 255, 0.12);
          background: rgba(255, 255, 255, 0.06);
          color: #eef5fb;
        }

        .toolbar-controls button,
        .preview-meta button {
          cursor: pointer;
          background: linear-gradient(135deg, #45b9ba, #0f3652);
          border: 0;
          font-weight: 700;
        }

        .toolbar-controls button:disabled {
          cursor: wait;
          opacity: 0.75;
        }

        .asset-note {
          margin-top: 20px;
          padding: 18px 20px;
          border-radius: 18px;
          color: rgba(238, 245, 251, 0.8);
          background: rgba(255, 255, 255, 0.05);
          border: 1px solid rgba(255, 255, 255, 0.08);
        }

        .asset-note code {
          padding: 2px 6px;
          border-radius: 8px;
          background: rgba(255, 255, 255, 0.08);
        }

        .preview-grid {
          display: grid;
          grid-template-columns: repeat(auto-fit, minmax(370px, 1fr));
          gap: 22px;
          margin-top: 28px;
        }

        .preview-card {
          padding: 18px;
          border-radius: 26px;
          background: rgba(5, 14, 22, 0.72);
          border: 1px solid rgba(255, 255, 255, 0.08);
          overflow: hidden;
        }

        .preview-meta {
          display: flex;
          justify-content: space-between;
          align-items: flex-start;
          gap: 16px;
          margin-bottom: 16px;
        }

        .preview-stage {
          height: 718px;
          padding: 20px;
          border-radius: 22px;
          background:
            linear-gradient(180deg, rgba(255, 255, 255, 0.05), rgba(255, 255, 255, 0.02)),
            #07111d;
          overflow: auto;
        }

        .preview-scaled {
          position: relative;
        }

        .export-surface {
          position: absolute;
          left: -99999px;
          top: 0;
          pointer-events: none;
        }

        .slide-canvas {
          position: relative;
          overflow: hidden;
          background: var(--canvas-bg);
          color: var(--canvas-fg);
        }

        .canvas-backdrop,
        .glow-orb {
          position: absolute;
          inset: 0;
        }

        .mesh {
          position: absolute;
          border-radius: 999px;
          filter: blur(8px);
          opacity: 0.92;
        }

        .mesh-a {
          width: 720px;
          height: 720px;
          top: -120px;
          left: -120px;
          background: radial-gradient(circle, rgba(69, 185, 186, 0.34), transparent 72%);
        }

        .mesh-b {
          width: 860px;
          height: 860px;
          right: -180px;
          top: 320px;
          background: radial-gradient(circle, rgba(244, 229, 198, 0.38), transparent 70%);
        }

        .mesh-c {
          width: 640px;
          height: 640px;
          left: 260px;
          bottom: -220px;
          background: radial-gradient(circle, rgba(139, 224, 218, 0.28), transparent 70%);
        }

        .layout {
          position: relative;
          z-index: 2;
          height: 100%;
        }

        .hero-layout,
        .split-layout,
        .panel-layout {
          display: grid;
          grid-template-columns: 1.05fr 0.95fr;
        }

        .hero-layout,
        .panel-layout {
          padding: 124px 96px 96px;
          gap: 24px;
        }

        .split-layout {
          padding: 110px 92px 92px;
          gap: 36px;
        }

        .stack-layout {
          display: grid;
          grid-template-rows: auto auto 1fr;
          padding: 110px 88px 88px;
          gap: 28px;
        }

        .closing-layout {
          display: grid;
          grid-template-rows: auto 1fr;
          padding: 104px 88px 88px;
          gap: 28px;
        }

        .copy-column,
        .panel-left,
        .closing-top {
          display: flex;
          flex-direction: column;
        }

        .hero-device-column,
        .device-column,
        .panel-right,
        .closing-bottom {
          position: relative;
        }

        .brand-header {
          display: flex;
          align-items: center;
          gap: 18px;
          margin-bottom: 28px;
        }

        .brand-mark {
          width: 108px;
          height: 108px;
          padding: 12px;
          border-radius: 28px;
          border: 1px solid var(--canvas-line);
          box-shadow: 0 16px 50px var(--canvas-shadow);
        }

        .brand-mark img {
          width: 100%;
          height: 100%;
          border-radius: 22px;
          object-fit: cover;
        }

        .brand-copy {
          display: grid;
          gap: 8px;
          max-width: 420px;
        }

        .brand-badge,
        .eyebrow {
          font-size: 22px;
          text-transform: uppercase;
          letter-spacing: 0.18em;
          color: var(--canvas-accent);
          font-weight: 700;
        }

        .brand-note {
          font-size: 22px;
          line-height: 1.35;
          color: var(--canvas-muted);
        }

        .brand-badge-inverse,
        .eyebrow-inverse {
          color: var(--canvas-accentWarm);
        }

        .brand-note-inverse,
        .body-copy-inverse,
        .headline-inverse {
          color: var(--canvas-fg);
        }

        .headline-block {
          display: grid;
          gap: 18px;
        }

        .headline {
          margin: 0;
          font-size: 132px;
          line-height: 0.92;
          letter-spacing: -0.08em;
          color: var(--canvas-fg);
        }

        .body-copy {
          margin: 0;
          max-width: 520px;
          font-size: 40px;
          line-height: 1.22;
          color: var(--canvas-muted);
        }

        .chip-row {
          display: flex;
          flex-wrap: wrap;
          gap: 14px;
          margin-top: 28px;
        }

        .chip {
          padding: 18px 24px;
          border-radius: 999px;
          border: 1px solid var(--canvas-line);
          font-size: 22px;
          font-weight: 700;
          letter-spacing: -0.03em;
          backdrop-filter: blur(10px);
        }

        .stat-card {
          display: inline-flex;
          flex-direction: column;
          gap: 8px;
          width: fit-content;
          margin-top: 34px;
          padding: 24px 28px;
          border-radius: 30px;
          background: rgba(255, 255, 255, 0.7);
          border: 1px solid var(--canvas-line);
          box-shadow: 0 20px 55px var(--canvas-shadow);
        }

        .stat-card-inverse {
          background: rgba(247, 251, 255, 0.1);
        }

        .stat-label {
          font-size: 20px;
          text-transform: uppercase;
          letter-spacing: 0.16em;
          color: var(--canvas-muted);
        }

        .stat-value {
          font-size: 36px;
          line-height: 1;
          letter-spacing: -0.06em;
          color: var(--canvas-fg);
        }

        .phone-shell {
          position: relative;
          aspect-ratio: ${MK_W}/${MK_H};
          filter: drop-shadow(0 36px 64px rgba(0, 0, 0, 0.24));
        }

        .phone-mockup,
        .phone-screen-image {
          width: 100%;
          height: 100%;
          display: block;
        }

        .phone-screen {
          position: absolute;
          overflow: hidden;
        }

        .phone-screen-image {
          object-fit: cover;
          object-position: top center;
        }

        .hero-phone {
          width: 520px;
          margin: 40px 0 0 auto;
          transform: rotate(5deg);
        }

        .split-phone {
          width: 560px;
          margin-top: 100px;
          transform: rotate(-7deg);
        }

        .stack-phone {
          width: 470px;
          transform: rotate(-4deg);
        }

        .panel-phone {
          width: 440px;
          margin: 12px auto 0;
        }

        .closing-phone {
          width: 430px;
          margin-left: auto;
          transform: rotate(8deg);
        }

        .feature-panel,
        .panel-right {
          display: grid;
          gap: 24px;
          padding: 34px;
          border-radius: 44px;
          border: 1px solid var(--canvas-line);
          box-shadow: 0 28px 70px var(--canvas-shadow);
        }

        .surface-light {
          background: rgba(255, 255, 255, 0.68);
        }

        .surface-dark {
          background: rgba(247, 251, 255, 0.08);
        }

        .stack-headline {
          max-width: 740px;
        }

        .feature-panel {
          grid-template-columns: 0.9fr 1.1fr;
          align-items: end;
        }

        .panel-layout {
          align-items: stretch;
        }

        .panel-left {
          justify-content: center;
          padding-right: 24px;
        }

        .panel-right {
          align-content: center;
          justify-items: center;
        }

        .split-copy {
          justify-content: center;
        }

        .split-phone-wrap,
        .closing-phone-wrap {
          display: flex;
          align-items: center;
          justify-content: center;
        }

        .closing-top {
          max-width: 760px;
        }

        .closing-bottom {
          display: grid;
          grid-template-columns: 0.85fr 1.15fr;
          align-items: end;
          gap: 20px;
        }

        .floating-note {
          position: absolute;
          left: 24px;
          bottom: 180px;
          padding: 22px 26px;
          border-radius: 28px;
          font-size: 28px;
          line-height: 1.2;
          letter-spacing: -0.04em;
          color: #0f3652;
          background: rgba(255, 244, 221, 0.92);
          box-shadow: 0 16px 40px rgba(15, 54, 82, 0.16);
        }

        .glow-orb {
          border-radius: 999px;
          filter: blur(10px);
        }

        .orb-a {
          width: 260px;
          height: 260px;
          top: 70px;
          right: 110px;
          background: radial-gradient(circle, rgba(69, 185, 186, 0.36), transparent 70%);
        }

        .orb-b {
          width: 320px;
          height: 320px;
          bottom: 140px;
          left: 10px;
          background: radial-gradient(circle, rgba(244, 229, 198, 0.42), transparent 70%);
        }

        .orb-c {
          width: 360px;
          height: 360px;
          top: 180px;
          left: 20px;
          background: radial-gradient(circle, rgba(139, 224, 218, 0.24), transparent 68%);
        }

        .orb-d {
          width: 420px;
          height: 420px;
          bottom: 140px;
          right: 0;
          background: radial-gradient(circle, rgba(69, 185, 186, 0.28), transparent 70%);
        }

        @media (max-width: 900px) {
          .app-shell {
            padding: 18px;
          }

          .preview-grid {
            grid-template-columns: 1fr;
          }

          .toolbar h1 {
            font-size: 26px;
          }
        }
      `}</style>
    </main>
  );
}
