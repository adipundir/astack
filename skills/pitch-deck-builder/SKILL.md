---
name: pitch-deck-builder
description: Build a clean, minimalist black-on-white investor pitch deck as a 16:9 PDF. Use when a user asks for a pitch deck, fundraising deck, investor deck, or any startup deck. Renders HTML with Inter typography, then converts to PDF via headless Chromium. Includes a canonical 12-slide structure (Title, Problem, Solution, How it works, Product, Market, Business Model, Traction, Competition 2x2, Why Now, Ask, Contact), a competitive 2x2 grid template, and product screenshot slots. Output is investor-ready in minutes.
---

# Pitch Deck Builder

Generate a minimalist, modern, investor-ready pitch deck as a PDF. Pure white background, near-black Inter type, big whitespace, one idea per slide. HTML-first then PDF, so every detail is editable.

## When to use

Trigger this skill when the user asks for any of:
- "pitch deck", "investor deck", "fundraising deck", "VC deck"
- "deck for my startup", "deck for [company]"
- "minimalist deck", "clean deck", "Linear-style deck", "YC-style deck"
- "deck as a PDF"

Do NOT use this skill for general-purpose presentations, lecture slides, or marketing decks. Use `marp-slide` for those.

## What you produce

A 12-slide, 1920×1080 PDF saved to a path the user can find (default: `~/Desktop/<company>-deck.pdf`).

The canonical 12-slide structure is:

| #  | Slide          | Purpose |
|----|----------------|---------|
| 01 | Title          | Wordmark, one-line tagline, founder + role |
| 02 | Problem        | One sentence. Why the status quo hurts. |
| 03 | Solution       | One sentence. What the product does. |
| 04 | How it works   | Three numbered steps, one line each |
| 05 | Product        | One clean product screenshot (PNG/JPG drop-in) |
| 06 | Market         | TAM number + source. One sentence. |
| 07 | Business model | How you make money. One sentence + unit fact. |
| 08 | Traction       | 4 specific stats: revenue, grants, users, partners |
| 09 | Competition    | 2×2 grid placing you in the top-right corner |
| 10 | Why now        | Why this is the right moment. One paragraph. |
| 11 | The ask        | Round size, instrument, valuation, runway, use of funds |
| 12 | Contact        | Name, email, URL, GitHub or socials |

If the user explicitly asks for a shorter deck (5, 8, 10 slides), drop in this priority order: Why Now → Market → How it works → Product → Competition.

## Workflow (always follow in order)

### Step 1 — gather inputs

Before generating, you MUST have these specifics from the user. Do not invent. If something is missing, ask in one consolidated question (not one at a time).

Required:
- **Company name** and one-line tagline
- **Founder name(s)** and role(s)
- **Problem statement** (1 sentence, plain English)
- **Solution statement** (1 sentence)
- **How it works** (3 short steps)
- **Business model** (how revenue works)
- **Traction** (real numbers: grants, revenue, users, paying customers, partnerships, awards)
- **Contact** (email, website URL)

Optional but improves the deck:
- **Product screenshot** path (PNG/JPG/WebP). If supplied, gets embedded into slide 5.
- **Market size** (TAM) with source
- **Competition list** (3 competitor names and one-line description each — used for the 2x2 grid)
- **Round details** (amount, instrument, cap/valuation, runway, use of funds)

If the user does not have market/ask details, render those slides with a `[TODO: ...]` placeholder in light gray italic text rather than skipping the slide. Tell the user which TODOs remain.

### Step 2 — write the HTML

Copy `assets/template.html` and fill it in. Read the template now to learn the markup before editing. Key conventions:

- Replace `{{company}}`, `{{tagline}}`, `{{founder_byline}}`, etc. tokens. The full token list is in `references/template-tokens.md`.
- For the product slide, if the user supplied a screenshot, replace the `<div class="img-ph">` placeholder with `<img class="product-shot" src="file:///abs/path/to/screenshot.png">`. Otherwise leave the placeholder div. Always use absolute `file:///` URIs since Chromium reads from disk.
- For the 2x2 competition grid, fill the four cells using the framework in `references/competitive-2x2.md`. Always put the company in the top-right cell (positive on both axes).
- Use `[TODO: ...]` (wrapped in `<span class="todo">`) for any data the user did not supply.

### Step 3 — render to PDF

Run `assets/build.sh` with two arguments: source HTML path and destination PDF path:

```bash
bash ~/.claude/skills/pitch-deck-builder/assets/build.sh /tmp/<company>-deck.html ~/Desktop/<company>-deck.pdf
```

The script auto-discovers Chrome/Chromium/Brave/Edge on macOS or Linux, then runs `--headless --print-to-pdf`. It will exit non-zero with a clear error if no Chromium-based browser is installed.

### Step 4 — report

Tell the user:
1. The PDF path
2. Which `[TODO]` placeholders remain (if any) and what data to supply to fill them
3. Whether the product screenshot was embedded or left as a placeholder

Do not open the file or attempt to preview it. Let the user open it.

## Design rules (do not break)

These are baked into the template. If you write custom CSS, follow these rules.

| Rule                | Value |
|---------------------|-------|
| Page size           | 1920×1080 (16:9) |
| Background          | `#ffffff` |
| Body text           | `#0a0a0a` |
| Muted text          | `#6b6b6b` |
| Hairline rule       | `#e6e6e6` |
| Placeholder fill    | `#fafafa` |
| Heading font        | Inter 600, letter-spacing −0.03em |
| Body font           | Inter 400, line-height 1.4 |
| Title size          | 128 px |
| Slide heading size  | 88 px |
| Body size           | 28 px |
| Margins (slide pad) | 120 px top/bottom, 160 px left/right |
| Em dashes           | NEVER. Use periods, commas, or non-breaking hyphens (&#8209;) |
| Bullet lists        | NEVER. Use numbered steps, hairline-rule rows, or 2-column stat grids |
| Italics             | Only for `[TODO]` placeholders |
| Emojis              | NEVER |

Tone: declarative sentences. No marketing fluff. No "revolutionary" / "disrupt" / "leverage" / "synergy". No exclamation marks.

## Iteration

When the user asks for changes after the first render, edit the HTML directly and re-run `build.sh`. Common edits:

- **Swap accent color** — define `--accent` in `:root` and use it on the `cell-us` cell or under the wordmark.
- **Drop a slide** — delete the `<section class="slide">` block and renumber the rest.
- **Add a slide** — copy an existing slide block, change `data-num`, and renumber the footer.
- **Increase content density** — only inside `.stats` (4-up) or `.steps` (3-up). Never add bullet lists.

## Reference files

- `assets/template.html` — the deck markup (read before editing)
- `assets/build.sh` — HTML→PDF renderer (auto-discovers Chromium browser)
- `references/template-tokens.md` — full list of `{{tokens}}` to replace
- `references/competitive-2x2.md` — framework for the competition grid
- `references/slide-copy-rules.md` — sentence patterns for each slide

## Notes for the agent

- This skill does not depend on the network at runtime, but the template links Inter from Google Fonts. If the deck must render offline, swap the `<link>` for a local Inter or accept the `-apple-system` fallback (the template includes a clean fallback chain).
- The PDF dimensions are pixel-accurate to 1920×1080. Resizing in tools like Pitch or Figma will work without distortion.
- If the user asks for "16:9 1080p" or "Google Slides size", the current template already matches that aspect.
