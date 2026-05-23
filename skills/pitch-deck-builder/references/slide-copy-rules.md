# Slide copy rules

The deck design carries the polish. The copy has to match. These rules apply to every token you fill in.

## General tone

- Declarative sentences. Subject-verb-object. No questions, no rhetorical flourishes.
- One idea per slide. If two ideas need to coexist, split the slide.
- Concrete over abstract. "$6K grant from MeitY Startup Hub" beats "non-dilutive funding secured".
- Active voice. "enwise collects USDC on Base" not "USDC is collected by enwise on Base".

## Forbidden vocabulary

Never use:

- Em dash `—`. Use periods, commas, or colons.
- Bullet points (• or –). Use the `.steps` row or `.stats` grid.
- Italics (except for the `<span class="todo">` placeholder).
- Emojis.
- These words: leverage, synergy, disrupt, revolutionary, paradigm, unleash, empower, holistic, robust, seamless, world-class, best-in-class, next-gen, game-changing, frictionless.
- Exclamation marks.
- Trailing ellipses `…`.

## Length budgets per slide

| Slide | Headline | Detail/body |
|-------|----------|-------------|
| Problem | ≤ 10 words | ≤ 30 words |
| Solution | ≤ 10 words | ≤ 30 words |
| How it works | ≤ 8 words | 3 steps × ≤ 12 words each |
| Product | ≤ 12 words | (image, no body) |
| Market | ≤ 12 words | ≤ 35 words |
| Business model | ≤ 10 words | ≤ 30 words |
| Traction | ≤ 6 words | 4 stats × short value + ≤ 18-word line |
| Competition | ≤ 8 words | (grid does the work) |
| Why now | ≤ 10 words | ≤ 50 words |
| The ask | ≤ 8 words | ≤ 40 words |

If you exceed a budget, cut the weakest words, do not shrink the font.

## Sentence patterns that work

**Problem.** State the user's natural expectation, then the actual cost.
> "Sending an invoice should take 30 seconds. QuickBooks turns it into 10 minutes."

**Solution.** State the new behavior the user gets, then the mechanism.
> "One sentence. Invoice, send, get paid. Driven through MCP."

**How it works.** Three imperative verbs.
> "Sign in. Connect your AI. Just ask."

**Traction.** Lead with the most specific number you have.
> "$6K MeitY grant. Mainnet USDC live. 5 AI clients supported."

**Why now.** One concrete event in the world, one consequence.
> "MCP standardised in late 2024. By 2026 every serious AI client speaks it."

**Ask.** Number, instrument, runway, use.
> "$750K SAFE. 18 months runway. Ships payments rail and hires one engineer."

## When the user has nothing real

Do not invent. Use `<span class="todo">[TODO: ...]</span>` and at the end of the build, tell the user every TODO you left, in priority order. Investors will catch fabricated traction numbers in five minutes, and that ends the meeting.

## Formatting numbers

- Money: `$6K`, `$750K`, `$2.4M`. No `USD`. No spaces.
- Multiples: `10×`, not `10x` or `10 X`.
- Percentages: `40%`, no space.
- Dates: `Q2 2026` or `April 2026`. Never `04/2026` or `4/26`.
- Use a non-breaking hyphen (`&#8209;`) inside compound terms that must not wrap, e.g. `form&#8209;filling`.
