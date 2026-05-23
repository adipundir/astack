# Template tokens

Every `{{token}}` in `assets/template.html` and what it expects. Replace literally before rendering. If you have no data for a token, replace it with a `[TODO: ...]` placeholder wrapped in `<span class="todo">[TODO: ...]</span>` and tell the user at the end.

## Universal

| Token | Goes on slides | Content |
|-------|----------------|---------|
| `{{company}}` | 1, footers, contact | Wordmark. Lowercase brand name, no period. Example: `enwise` |
| `{{year}}` | 1 | Current year, e.g. `2026` |
| `{{website}}` | 1, 12 | Bare URL, no protocol. Example: `enwise.app` |

## 01 · Title

| Token | Content |
|-------|---------|
| `{{tagline}}` | One sentence, sub-headline tone. Sentence case, period at end. Example: `Invoicing built for AI agents.` |
| `{{founder_byline}}` | `Founder Name · Role`. ALL CAPS rendering is automatic via CSS. Example: `Aditya Pundir · Founder` |

## 02 · Problem

| Token | Content |
|-------|---------|
| `{{problem_headline}}` | One short, declarative sentence (≤ 10 words). Names the pain. Example: `Sending an invoice should take 30 seconds.` |
| `{{problem_detail}}` | One muted sentence elaborating the cost of the status quo. ≤ 30 words. Example: `QuickBooks and Zoho turn it into 10 minutes of form-filling across 5 screens. Then you still need Stripe or a bank wired up to actually get paid.` |

## 03 · Solution

| Token | Content |
|-------|---------|
| `{{solution_headline}}` | One declarative sentence. What the product does, plainly. Example: `One sentence. Invoice, send, get paid.` |
| `{{solution_detail}}` | Muted sentence with one concrete mechanism. Example: `enwise generates the invoice, emails it to the client, and collects USDC settlement on Base. To a human user, or to an AI agent over MCP.` |

## 04 · How it works

| Token | Content |
|-------|---------|
| `{{how_headline}}` | One line setting up the three steps. Example: `Three steps. Under two minutes.` |
| `{{step1_title}}` | 2 to 4 words. Example: `Sign in` |
| `{{step1_detail}}` | One short line. Example: `GitHub or Google. API key minted once.` |
| `{{step2_title}}` | Example: `Connect your AI` |
| `{{step2_detail}}` | Example: `One-shot setup for Claude, Cursor, Codex, Windsurf, Antigravity.` |
| `{{step3_title}}` | Example: `Just ask` |
| `{{step3_detail}}` | Example: `"Bill Northwind $1,500 for design work." The agent does the rest.` |

## 05 · Product

| Token | Content |
|-------|---------|
| `{{product_headline}}` | One descriptive line for the screenshot. Example: `A clean, hosted invoice. PDF, share link, pay button.` |
| `{{product_caption}}` | Short caption, used only when the image is a placeholder. Example: `invoice share page` |

If you have a screenshot path, replace the entire `<div class="img-ph">…</div>` line in slide 5 with:
```html
<img class="product-shot" src="file:///absolute/path/to/screenshot.png" alt="Product screenshot" />
```

## 06 · Market

| Token | Content |
|-------|---------|
| `{{market_headline}}` | Headline with a number if you have it. Example: `SMB invoicing is a $32B market.` |
| `{{market_detail}}` | Source + framing. Example: `Global SMB accounting + invoicing software, Statista 2025. Every solo founder, freelancer, agency, and contractor sends invoices.` |

## 07 · Business model

| Token | Content |
|-------|---------|
| `{{model_headline}}` | How you make money, in one line. Example: `Free to invoice. Small cut on payments.` |
| `{{model_detail}}` | One sentence on mechanics + pricing. Example: `Merchants pay nothing to create and send invoices. enwise takes a small percentage on every payment that moves through the platform.` |

## 08 · Traction

| Token | Content |
|-------|---------|
| `{{traction_headline}}` | Short, factual. Example: `Shipped. Live. Funded.` |
| `{{stat1_big}}` through `{{stat4_big}}` | One short value per cell. Numbers, dollar amounts, dates, or single words. Example: `$6K`, `Live`, `5`, `Open` |
| `{{stat1_small}}` through `{{stat4_small}}` | One short line explaining the value. ≤ 18 words. |

Pick the four strongest from this list: revenue, paying customers, grants, partnerships, MAUs, GitHub stars, launch dates, awards. If you only have three, leave one cell as `[TODO]`.

## 09 · Competition

The 2×2 grid puts you in the top-right. See `references/competitive-2x2.md` for axis selection.

| Token | Content |
|-------|---------|
| `{{comp_headline}}` | One line claiming your position. Example: `Nothing else sits where we sit.` |
| `{{axis_h_left}}` | Negative end of horizontal axis. Example: `Fiat only` |
| `{{axis_h_right}}` | Positive end of horizontal axis. Example: `Crypto-native` |
| `{{axis_v_top}}` | Positive end of vertical axis. Example: `Agent-native` |
| `{{axis_v_bottom}}` | Negative end of vertical axis. Example: `Form-based` |
| `{{cell_tl_name}}` / `{{cell_tl_desc}}` | Top-left competitor: positive on one axis only |
| `{{cell_bl_name}}` / `{{cell_bl_desc}}` | Bottom-left competitor: negative on both |
| `{{cell_br_name}}` / `{{cell_br_desc}}` | Bottom-right competitor: positive on the other axis |
| `{{cell_us_desc}}` | YOUR description (the company name is auto-filled). Example: `Built MCP-first. USDC settlement on Base. Open source.` |

## 10 · Why now

| Token | Content |
|-------|---------|
| `{{whynow_headline}}` | One declarative sentence on the moment. Example: `Agents are becoming the interface.` |
| `{{whynow_detail}}` | A paragraph (≤ 50 words) on the wave. Cite a concrete fact (a standard ratifying, a regulation, a platform launch). |

## 11 · The ask

| Token | Content |
|-------|---------|
| `{{ask_headline}}` | One line summarising the ask. Example: `Raising $750K SAFE.` |
| `{{ask_detail}}` | Specifics. Example: `$750K on a SAFE at $8M cap. 18 months of runway. Builds out the payments rail, hires one engineer, ships private settlement.` |

## 12 · Contact

| Token | Content |
|-------|---------|
| `{{contact_name}}` | `Name · Role`. Example: `Aditya Pundir · Founder` |
| `{{contact_email}}` | Email. Example: `aditya@enwise.app` |
| `{{contact_extra}}` | One more handle: GitHub, X, LinkedIn. Example: `github.com/adipundir/enwise` |
