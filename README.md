# astack

Aditya's Claude Code skill pack. Opinionated tools that turn Claude into a sharper collaborator — one skill at a time.

This repo starts with one skill and will grow. Each skill is self-contained: drop it into `~/.claude/skills/` and Claude Code picks it up automatically.

## Skills

| Skill | What it does |
|---|---|
| [`pitch-deck-builder`](skills/pitch-deck-builder/) | Generates a clean, minimalist, investor-ready 12-slide pitch deck as a 16:9 PDF. Black-on-white, Inter typography, no fluff. HTML-first → headless Chromium → PDF. |

## Install

### Quick install (all skills)

```bash
curl -fsSL https://raw.githubusercontent.com/adipundir/astack/main/install.sh | bash
```

This copies every skill in `skills/` into `~/.claude/skills/`. Re-run any time to update.

### Manual install (one skill)

```bash
git clone https://github.com/adipundir/astack.git
cp -R astack/skills/pitch-deck-builder ~/.claude/skills/
```

Restart Claude Code (or open a fresh session) and the skill is available.

## Using pitch-deck-builder

Once installed, just ask Claude:

> Build me a pitch deck for my startup.

Claude will pick up the skill, ask for the inputs it needs (company name, problem, solution, traction, ask, contact, optional screenshot), then render a 1920×1080 PDF to `~/Desktop/<company>-deck.pdf`.

**Requirements:** A Chromium-based browser installed locally (Chrome, Chromium, Brave, or Edge). The skill auto-discovers it.

See [`skills/pitch-deck-builder/SKILL.md`](skills/pitch-deck-builder/SKILL.md) for the full spec — slide-by-slide structure, design rules, and iteration patterns.

## Contributing your own

This repo is mine, but the pattern is portable. To build your own `*stack`:

1. Create skills under `~/.claude/skills/<your-skill>/SKILL.md`.
2. Test them in Claude Code until they feel sharp.
3. Copy the folder into a new repo's `skills/` directory.
4. Steal this README and `install.sh`.

## License

MIT — see [LICENSE](LICENSE).
