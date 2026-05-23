# Competitive 2×2 grid

The competition slide uses a 2×2 grid that places the company in the top-right corner. The grid is most persuasive when the two axes are real, named dimensions where the company genuinely sits on the positive end of both.

## Choosing axes

Pick two axes such that:

1. The company sits in the top-right (positive on both axes). If it doesn't, switch the axes until it does.
2. Each axis is a meaningful product / market dimension. Not "good vs bad". Not "modern vs old".
3. At least one real competitor exists in each of the other three quadrants. If a quadrant is empty, that's fine but say so.
4. The axes are orthogonal. They should describe independent properties, not the same thing twice.

## Strong axis patterns

| Product type | Good axis pair |
|--------------|----------------|
| Dev tools | AI-native ↔ Traditional · Open-source ↔ Closed |
| Fintech | Crypto-native ↔ Fiat only · Agent-native ↔ Form-based |
| Consumer SaaS | Bottom-up ↔ Top-down · Async ↔ Real-time |
| Marketplaces | Two-sided ↔ One-sided · Vertical ↔ Horizontal |
| Infra | Self-host ↔ Managed only · Multi-cloud ↔ Single-cloud |

## Weak axes to avoid

- "Easy to use ↔ Hard to use" — every company claims to be easy.
- "Fast ↔ Slow" — same problem.
- "Modern ↔ Legacy" — same problem.
- "Cheap ↔ Expensive" — usually a feature, not a positioning dimension.
- "Has feature X ↔ Doesn't have feature X" — too granular, looks like a comparison chart, not positioning.

## Filling the four cells

Top-right (you): one short sentence on the cross-section.

For the other three quadrants, pick one or two competitors per cell that are genuinely there. Use real names if the user supplied them. If the user did not, leave the cell as `[TODO: name 1 to 2 competitors that are <axis-bottom> and <axis-right>]`.

Cell description format: `<one-line-positioning>. <one-line-limitation>.` Stay neutral, not snarky. The grid does the persuading.

Example (enwise):

| | Fiat only | Crypto-native |
|---|---|---|
| **Agent-native** | Stripe Invoicing + Zapier hacks. Bolt-on automation. Not an agent-first product. | **enwise. Built MCP-first. USDC settlement on Base. Open source.** |
| **Form-based** | QuickBooks, Zoho, FreshBooks. Heavy forms. Built for accountants. No agent surface. | Request Finance, Bitwage. Crypto rails, but the UX is still spreadsheets and forms. |

## Iterating with the user

If the user pushes back on the 2×2, the usual fixes are:

1. The user disagrees with their own placement → change the description on the `cell-us` cell. The grid still works.
2. The user disagrees with a competitor's placement → ask which axis is wrong, then either move the competitor or swap the axis.
3. The user wants a feature-matrix instead → tell them that's a different slide. The 2×2 is for positioning, not feature counting. Offer to add a separate matrix slide.
