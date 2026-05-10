---
type: config
last-updated: 2026-05-10
---

# Board Configuration (Template)

> Your actual config lives in your Obsidian vault at `board/config/board.md`.
> Run `/setup` to create it.

## Data Sources

The board reads context from these sources. Set the ones you use.

### Obsidian Vault (primary)

The vault path is stored locally in the board repo at `00_config/.vault-path` (created by `/setup`). The context-loader uses that pointer to discover relevant files automatically.

### Connected Services (optional)

These require MCP servers to be connected in Claude Code. If not connected, the context-loader skips them gracefully.

| Source | MCP Tools | What it provides |
|---|---|---|
| Google Drive | `mcp__claude_ai_Google_Drive__*` | Shared docs, spreadsheets, slide decks |
| Notion | `mcp__claude_ai_Notion__*` | Wikis, databases, project trackers |
| Gmail | `mcp__claude_ai_Gmail__*` | Recent correspondence, deal threads |
| Google Calendar | `mcp__claude_ai_Google_Calendar__*` | Upcoming commitments, availability |
| Web Search | `WebSearch` / `WebFetch` | Current market data, competitor info, trends |

```
google_drive: false
notion: false
gmail: false
google_calendar: false
web_search: false
```

## Active Advisors

Advisors with `active: true` participate in board sessions. Deactivate any you don't need.

| Advisor | Slug | Domain | Active |
|---|---|---|---|
| Steve Jobs | steve-jobs | Innovation & Product | true |
| Warren Buffett | warren-buffett | Finance & M&A | true |
| David Ogilvy | david-ogilvy | Media & Advertising | true |
| Andrew Grove | andrew-grove | Management & Org | true |
| MrBeast | mrbeast | Creativity & Attention | true |
| Dalai Lama | dalai-lama | Moral & Wisdom | true |
| Sun Tzu | sun-tzu | Strategy & Special Situations | true |
| Harvey Specter | harvey-specter | Negotiation & Special Situations | true |
| Alex Hormozi | alex-hormozi | Sales & Offer Design | true |

## Session Defaults

```
max_advisor_words: 300
save_sessions: true
session_dir: board/sessions/
```
