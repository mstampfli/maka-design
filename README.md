# Maka Design System

Maka is a warm, earthy, slightly retro-terminal design language built for the Maka OS project. Dark by default (deep roasted brown), with a paper-cream light variant. Everything derives from one token file, recolor the entire system by editing `tokens.css`.

## Index

| File | What it is |
|---|---|
| `styles.css` | **Global entry point**, consumers link only this. `@import`s fonts + tokens + components. |
| `tokens.css` | All CSS custom properties: palette, semantic aliases, type, spacing, radii. Dark on `:root`, light under `[data-theme="light"]`. |
| `maka.css` | Reset + every component (classes prefixed `mk-`). No raw colors, token references only. |
| `kitchen-sink.html` | Demo page showing every component, with a working dark/light toggle. |
| `guidelines/` | Specimen cards for the Design System tab. |
| `SKILL.md` | Agent skill entry point. |

## Visual foundations

- **Color**: deep roasted-brown backgrounds (`#1a120b` page), warm surface browns, burnt-orange primary accent (`#e0731d`), amber highlight, cream text. Light variant: paper cream page, dark-roast brown ink, slightly deepened orange (`#c75f0d`) for contrast. Status colors stay earthy: sage green success, warm red danger, amber warn. No blues, no purples, no gradients.
- **The signature**: a `2px` warm-brown border (`--mk-border`) on every framed element, cards, inputs, tables, code blocks, navbar rule. On hover it strengthens (`--mk-border-strong`); on interactive elements and focus it turns **orange**. This frame is what makes a surface read as Maka.
- **Type**: IBM Plex Mono for headings, labels, buttons, kickers, inputs, numerals (tabular). IBM Plex Sans for body copy. Kickers are mono, uppercase, `letter-spacing: 0.14em`, prefixed `// ` (the slashes render faint). 15px/1.65 body.
- **Texture**: faint horizontal scanlines over the whole page (`body::before`, ~3% opacity, themed via `--mk-scanline`). Opt out with `class="mk-no-scanlines"` on `<body>`.
- **Geometry**: near-square radii, 2/4/6px. Spacing scale 4·8·12·16·24·32·48·72. Borders carry depth; shadows are reserved for popovers (`--mk-shadow-pop`).
- **Motion**: 120ms ease color/border transitions only. Buttons nudge down 1px on press. No bounces, no fades-in.
- **Focus**: terminal-style, `2px solid var(--mk-focus)` outline, `outline-offset: 2px`, on everything via `:focus-visible`. Inputs instead swap their border to orange.
- **Hover states**: border-color changes, never background washes (except table rows, which tint to `--mk-surface-2`).
- **Selection**: orange background, dark-roast text.
- **Layout / wrapping rows**: rows are wrapping flexbox (`.mk-row`, `.mk-card__header`) and left-align by default. To drop a status badge or any item onto its own line, wrap it in `.mk-break`: the wrapper spans the full row so its contents start a new line at the left, at natural width, separated by the row's normal gap (one gap, not two). Status badges go on a new line at the left, never right-pushed.

## Content fundamentals

- Terse, lowercase, systems-flavored microcopy in mono contexts: `get_started`, `[ light_mode ]`, `us-west`, `// components / buttons`. Sentence case for body prose.
- Alert prefixes are bracketed mono tags: `[ info ]`, `[ ok ]`, `[ warn ]`, `[ fail ]`.
- No emoji. No exclamation points. Calm, dry, a little wry.

## Iconography

No icon font is bundled. The system uses **unicode glyphs as icons**: `▾` (select chevron), `→` (links), `▮`/square `.mk-logo-mark` (brand mark), `//` (kicker prefix), `$` (shell prompt), `©`. If a real icon set is ever needed, use Lucide from CDN at 1.5px stroke to match the 2px-frame weight, and flag the addition.

## Theming

- Dark is the default (`:root`). Add `data-theme="light"` to `<html>` for the paper variant.
- Components reference only **semantic** tokens (`--mk-surface-1`, `--mk-border`, `--mk-accent`…), which alias the base palette (`--mk-brown-*`, `--mk-orange-*`…). To rebrand, edit the base palette; to retune a role, edit an alias.
- Status tints are derived with `color-mix()` from single status tokens, no hand-picked tint colors exist.

## Sources

Built from a written brief (June 2026), no external Figma/codebase sources. Palette anchors specified by the brand owner: page `#1a120b`, accent `#e0731d`.
