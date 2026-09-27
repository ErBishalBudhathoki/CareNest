---
name: Neo-Industrial Ledger
colors:
  surface: '#FFF9E6'
  surface-dim: '#E5D4AF'
  surface-bright: '#FFFCF5'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#FBF4DE'
  surface-container: '#F5E9CE'
  surface-container-high: '#EFE0C2'
  surface-container-highest: '#E8D8B5'
  on-surface: '#1A1A1A'
  on-surface-variant: '#3D3728'
  inverse-surface: '#313030'
  inverse-on-surface: '#f3f0ef'
  outline: '#1A1A1A'
  outline-variant: '#d3c5ab'
  surface-tint: '#785a00'
  primary: '#785a00'
  on-primary: '#ffffff'
  primary-container: '#ffc300'
  on-primary-container: '#6d5200'
  inverse-primary: '#f8be00'
  secondary: '#006876'
  on-secondary: '#ffffff'
  secondary-container: '#92edff'
  on-secondary-container: '#006d7b'
  tertiary: '#bb152c'
  on-tertiary: '#ffffff'
  tertiary-container: '#ffbbb9'
  on-tertiary-container: '#af0425'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#ffdf9a'
  primary-fixed-dim: '#f8be00'
  on-primary-fixed: '#251a00'
  on-primary-fixed-variant: '#5a4300'
  secondary-fixed: '#9eefff'
  secondary-fixed-dim: '#77d4e5'
  on-secondary-fixed: '#001f24'
  on-secondary-fixed-variant: '#004e59'
  tertiary-fixed: '#ffdad8'
  tertiary-fixed-dim: '#ffb3b1'
  on-tertiary-fixed: '#410007'
  on-tertiary-fixed-variant: '#92001c'
  background: '#FFF9E6'
  on-background: '#1c1b1b'
  surface-variant: '#F8EED6'
  outline-solid: '#000000'
  action-blue: '#1D4ED8'
  action-blue-hover: '#1E40AF'
typography:
  display:
    fontFamily: Bricolage Grotesque
    fontSize: 56px
    fontWeight: '800'
    lineHeight: 60px
    letterSpacing: -0.04em
  display-mobile:
    fontFamily: Bricolage Grotesque
    fontSize: 36px
    fontWeight: '800'
    lineHeight: 40px
    letterSpacing: -0.03em
  headline-lg:
    fontFamily: Bricolage Grotesque
    fontSize: 40px
    fontWeight: '700'
    lineHeight: 44px
    letterSpacing: -0.03em
  headline-lg-mobile:
    fontFamily: Bricolage Grotesque
    fontSize: 28px
    fontWeight: '700'
    lineHeight: 32px
    letterSpacing: -0.02em
  headline-md:
    fontFamily: Bricolage Grotesque
    fontSize: 28px
    fontWeight: '700'
    lineHeight: 32px
    letterSpacing: -0.02em
  headline-sm:
    fontFamily: Bricolage Grotesque
    fontSize: 20px
    fontWeight: '700'
    lineHeight: 24px
    letterSpacing: -0.01em
  body-lg:
    fontFamily: Space Mono
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
    letterSpacing: -0.01em
  body-md:
    fontFamily: Space Mono
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
    letterSpacing: 0em
  body-sm:
    fontFamily: Space Mono
    fontSize: 12px
    fontWeight: '400'
    lineHeight: 16px
    letterSpacing: 0em
  label-lg:
    fontFamily: Space Mono
    fontSize: 13px
    fontWeight: '700'
    lineHeight: 16px
    letterSpacing: 0.06em
  label-sm:
    fontFamily: Space Mono
    fontSize: 11px
    fontWeight: '700'
    lineHeight: 14px
    letterSpacing: 0.08em
spacing:
  gutter: 1rem
  gutter-desktop: 1.5rem
  margin: 1rem
  margin-desktop: 2rem
  space-xs: 0.25rem
  space-sm: 0.5rem
  space-md: 1rem
  space-lg: 1.5rem
  space-xl: 2.5rem
---

## Brand & Style
Neo-Industrial Ledger embodies a high-utility, neo-brutalist financial audit interface designed for engineers, financial operators, and forensic accountants. The aesthetic prioritizes absolute legibility, rapid data processing, and tactile feedback.

Key design attributes:
- **Design Movement:** Neo-Brutalism fused with industrial terminal instrumentation.
- **Visual Rhythm:** Heavy solid stroke borders (`2px` to `2.5px`), offset hard-drop shadows with zero blur, and distinct technical status indicators.
- **Atmosphere:** Rigorous, dense, tactile, and unapologetically engineered, evoking specialized hardware monitors and retro-futuristic financial matrix tools.

## Colors
The palette utilizes an architectural parchment base (`#FFF9E6` to `#FFFCF5`) anchored by pure structural pitch black (`#000000` / `#1A1A1A`) for borders and typography.

Palette Roles:
- **Primary (`#FFC300`):** High-visibility hazard yellow used for active states, tab headers, and primary identifier tags.
- **Secondary (`#028090`):** Muted industrial teal/cyan used for verified states, approvals, and positive metrics.
- **Tertiary (`#E63946`):** Vibrant warning crimson for rejections, expense drains, and audit alerts.
- **Action Blue (`#1D4ED8`):** Direct actionable triggers (e.g., voucher entry, transaction commitments) and reimbursement indicators.
- **Surface Hierarchy:** Layering is achieved via parchment tints ranging from container tones (`#F8EED6`, `#F5E9CE`) to elevated card surfaces (`#FFFCF5`).

## Typography
The system enforces a dual-typeface typographic contrast:
- **Display & Headlines:** Set in `Bricolage Grotesque` (700/800 weights). Characterized by compressed, aggressive geometry and tight tracking, ideal for financial sums, critical statuses, and section designations. Always styled in uppercase for titles.
- **Body & Labels:** Set in `Space Mono`. Used for all tabular data, IDs, status chips, code identifiers, and body copy. Monospaced tabular alignment guarantees predictable decimal and character columns across all screen sizes.

## Layout & Spacing
A fluid 4-column layout is used on mobile, expanding to an 8-column layout on tablet and a 12-column layout on desktop.

Layout Rules:
- **Margins & Gutters:** Base mobile canvas margin is fixed at `1rem` (`16px`). Vertical gaps between sections maintain a consistent `space-lg` (`1.5rem`) cadence.
- **Rhythm:** Dense internal component padding uses `space-xs` (`4px`) and `space-sm` (`8px`) to maximize data density while preserving distinct structural boundaries.
- **Fixed Infrastructure:** The top app bar (`h-16`) and rigid bottom nav (`h-16`) remain pinned with `z-50` elevation, offset by matching top and bottom padding (`pt-16`, `pb-24`) to prevent content overlap.

## Elevation & Depth
Depth is created strictly through physical neo-brutalist hard offsets rather than soft ambient blur shadows.

Key conventions:
- **Structural Outlines:** All interactive and elevated containers feature a mandatory `2px` or `2.5px` solid `#000000` border.
- **Hard Cast Shadows:** Cards, interactive action buttons, and segmented headers use directional drop shadows with zero blur:
  - Base Cards & Sections: `shadow-[4px_4px_0px_#000000]`
  - Medium Buttons & Nav Segments: `shadow-[3px_3px_0px_#000000]`
  - Small Controls & Badges: `shadow-[2px_2px_0px_#000000]`
  - Fixed Bars: Directional top or bottom shadow strokes (`shadow-[0_2px_0px_#000000]` / `shadow-[0_-2px_0px_#000000]`).
- **Tactile Depression:** On active states (`:active`), clickable elements translate positively (`translate-x-[2px] translate-y-[2px]`) while collapsing their shadow to `none`, simulating a tactile mechanical switch.

## Shapes
Geometry is strictly sharp (`roundedness: 0`). 

- Corners are unrounded (`0px`) across all cards, badges, buttons, progress tracks, and layout segments to reinforce the technical blueprint aesthetic.
- The only permissible circular geometry (`rounded-full`) is reserved for minute functional terminal indicators (e.g., live-feed pulse LEDs and active segment indicators).

## Components

### Buttons
- **Action Button:** Full-width or inline, `h-11`, solid background (`#1D4ED8` or `#FFC300`), text in `#FFFFFF` or `#000000`, `2.5px` solid `#000000` border, `shadow-[3px_3px_0px_#000000]`. Transitions via active transform (`translate-x-[3px] translate-y-[3px]` and `shadow-none`).
- **Icon Utility Button:** Square `w-10 h-10`, centered Material Symbol (`20px`), `2.5px` border with `shadow-[2px_2px_0px_#000000]`.

### Cards & Modules
- **Ledger Card:** Background `#FFFCF5` enclosed by a `2.5px` black border and `4px 4px 0px #000000` shadow. Often includes a contrasting header strip (e.g., yellow `#FFC300`) with a bottom separator border.
- **Metric Micro-Card:** Compact 2x2 grid tiles featuring a top status bar, icon block with `2px` black border, bold monospaced value, and divider line for secondary metadata.

### Segmented Controls & Navigation
- **Strip Tabs:** Grid-bound full-width strip with `2.5px` outer border, `2px` column dividers. Inactive tabs use `#F8EED6`; active tabs use inverted black (`#000000`) with primary yellow (`#FFC300`) text and accent dot.
- **Bottom Matrix Nav:** `h-16` bar with equal tab distribution. Active item highlighted with `#FFC300` background, flanking vertical `2.5px` black borders, and heavy label typography.

### Data Bars & Chips
- **Progress Matrix:** Rigid stacked progress bar with high-contrast color segments (`#028090` and `#E63946`), bounded by `2.5px` black border and inner vertical divider lines.
- **Status Badges / Chips:** Sharp rectangular tags with `1px` or `1.5px` solid black borders, monospaced text, and semantic background fills (e.g., `#028090` for SETTLED, `#FFC300` for ID tags).