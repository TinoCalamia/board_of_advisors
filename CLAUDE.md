# Board of Advisors

A virtual advisory council of nine legendary minds, each a Claude Code subagent with a distinct voice, decision-making framework, and domain expertise. Ask a strategic question — get nine perspectives, then a synthesized recommendation.

## The Board

| # | Advisor | Domain | Signature | When to Consult |
|---|---------|--------|-----------|-----------------|
| 01 | Steve Jobs | Innovation & Product | "Stay hungry, stay foolish." | Product direction, differentiation, simplification, category creation |
| 02 | Warren Buffett | Finance & M&A | "Price is what you pay. Value is what you get." | Pricing, capital allocation, M&A, business model, financial risk |
| 03 | David Ogilvy | Media & Advertising | "The consumer is not a moron. She's your wife." | Marketing, messaging, positioning, content strategy, brand |
| 04 | Andrew Grove | Management & Org | "Only the paranoid survive." | Hiring, org design, process, culture, operational scaling |
| 05 | MrBeast | Creativity & Attention | "The first 5 seconds decide everything." | Content, distribution, audience growth, viral strategy, hooks |
| 06 | Dalai Lama | Moral & Wisdom | "Be kind whenever possible. It is always possible." | Ethical dilemmas, stakeholder impact, culture, purpose, sustainability |
| 07 | Sun Tzu | Strategy & Special Sit. | "Win first, then go to war." | Competitive strategy, market entry, positioning, complex adversarial situations |
| 08 | Harvey Specter | Negotiation & Special Sit. | "I don't have dreams. I have goals." | Negotiations, partnerships, contracts, high-stakes conversations |
| 09 | Alex Hormozi | Sales & Offer Design | "Make people an offer so good they feel stupid saying no." | Pricing, offer design, sales process, lead generation, retention, revenue growth |

## Vault pointer

User configuration and session data are stored in the user's Obsidian vault, NOT in this repo. This keeps the repo clean and distributable — no one accidentally pushes their private business data.

The file `00_config/.vault-path` contains the absolute path to the user's vault. Every skill reads this file first. If it does not exist, the user must run `/setup`.

**Vault structure (created by `/setup`):**

```
{vault}/board/
  config/
    board.md       — board configuration (data sources, advisor flags, session defaults)
    context.md     — business context (company, priorities, numbers, competitors)
  sessions/        — session records (dated logs of every convening, debate, review)
```

## How this repo is organized

| Folder | Purpose |
|---|---|
| `00_config/` | Template config files and local vault pointer (`.vault-path`). User config lives in their vault at `board/config/`. |
| `01_advisors/` | Deep persona files for each advisor: biography, philosophy, frameworks, quotes, mental models. The knowledge base powering each subagent. |
| `02_sessions/` | Session template only. Live session records are saved to the user's vault at `board/sessions/`. |
| `03_playbooks/` | Procedural guides: how each session type runs step by step. |
| `lib/` | Shared scripts (hooks). |
| `dashboards/` | Obsidian Dataview dashboards (reference copies). |
| `templates/` | Obsidian Templater templates. |

## Skills (Claude Code slash commands)

| Skill | What it does |
|---|---|
| `/setup` | Interactive configuration: set vault path, data sources, business context, active advisors |
| `/ask <advisor> <question>` | Ask a single advisor a strategic question |
| `/convene-board <question>` | Full board session: all active advisors respond in parallel, synthesizer produces INSIGHTS / RISKS / OPTIONS / RECOMMENDATION |
| `/debate <question>` | Multi-round debate: advisors take positions, then rebut each other before synthesis |
| `/strategic-review` | Comprehensive business assessment: each advisor reviews their domain using vault data |
| `/risk-scan <topic>` | Risk analysis from all 9 perspectives, produces a risk matrix |

## How the board works

```
User Question
    |
    v
Orchestrator (skill)
    |
    +-- reads 00_config/.vault-path --> finds user's vault
    |
    +-- context-loader subagent --> reads vault + Drive + Notion + Gmail + Calendar + web
    |                               --> returns compressed business context (max 400 words)
    |
    +-- [parallel] 9 advisor subagents --> each reads its own persona + frameworks + context
    |                                      --> returns perspective in character (max 300 words)
    |
    +-- board-synthesizer subagent --> collects all perspectives
                                      --> produces INSIGHTS | RISKS | OPTIONS | RECOMMENDATION | DISSENT
```

## Data sources

The board reads from multiple sources configured in the user's vault at `board/config/board.md`:

- **Obsidian vault** (primary): local path, discovered via `find`/`grep`
- **Google Drive**: via MCP tools (opt-in)
- **Notion**: via MCP tools (opt-in)
- **Gmail**: via MCP tools (opt-in)
- **Google Calendar**: via MCP tools (opt-in)
- **Web search**: via `WebSearch`/`WebFetch` (on by default)

If a source is not configured or its MCP server is not connected, the context-loader skips it.

## Token efficiency rules

1. **Never read all 9 persona files at once.** For `/ask`, read only the one advisor. For `/convene-board`, the orchestrator dispatches 9 parallel subagents — each reads only its own persona.
2. **For vault context**: use `context-loader` subagent. It uses `grep`/`find` first, then reads only matched files.
3. **Dashboard files** are for Obsidian only — never read them.
4. **Session records**: only read if the user explicitly asks for history. Do not load proactively.

## Operating principles

1. **Vault pointer is the bootstrap.** Always read `00_config/.vault-path` first, then read `{vault_path}/board/config/board.md` and `{vault_path}/board/config/context.md` before any session.
2. **Each advisor stays in character.** The subagent must embody the advisor's voice, values, and frameworks. No generic AI filler.
3. **Disagreement is the point.** Advisors should disagree. The value is in the tension between perspectives.
4. **Context over speculation.** If data is missing, say so rather than speculate.
5. **Session records are dated.** ISO dates (`YYYY-MM-DD`) in filenames. Saved to user's vault.
6. **No sycophancy.** Advisors push back. They challenge assumptions.

## Frontmatter convention

Every file must have YAML frontmatter.

**Required field:** `type` — one of: `config`, `persona`, `framework`, `session`, `playbook`, `index`, `dashboard`, `template`.

**Common fields:**

| Field | Used by | Purpose |
|---|---|---|
| `type` | All files | Powers queries and dashboards |
| `advisor` | Persona, framework files | Links to an advisor slug |
| `date` | Sessions | When the session happened |
| `session-type` | Sessions | `full-board`, `single`, `debate`, `review`, `risk-scan` |
| `question` | Sessions | The strategic question asked |
| `topics` | Sessions | Cross-cutting topic tags |

## Linking convention

Use **standard markdown links** (not wikilinks):

```markdown
See [Steve Jobs persona](01_advisors/steve-jobs/persona.md) for his thinking style.
```

## Naming conventions

- Advisor slug: lowercase-hyphenated (e.g., `steve-jobs`, `warren-buffett`)
- Session files: `{vault}/board/sessions/YYYY-MM-DD-slug.md`
- All dates: ISO format (`YYYY-MM-DD`)

## When in doubt

- New user? Run `/setup` first.
- Quick question for one advisor? `/ask jobs Should we simplify our pricing?`
- Big strategic question? `/convene-board Should we raise or bootstrap?`
- Contentious topic? `/debate Should we build or buy?`
- Broad assessment? `/strategic-review`
- Worried about something? `/risk-scan entering the enterprise market`
