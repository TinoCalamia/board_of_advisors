---
description: Interactive configuration — set your vault path, data sources, business context, and active advisors
argument-hint: (no arguments needed)
allowed-tools: [Read, Write, Edit, Bash, mcp__claude_ai_Gmail__list_labels, mcp__claude_ai_Google_Calendar__list_calendars, mcp__claude_ai_Google_Drive__list_recent_files, mcp__claude_ai_Notion__notion-get-teams, WebSearch]
---

# Setup

Walk the user through configuring their board of advisors. This is a guided conversation — ask each section, confirm, then write.

## Step 1 — Read current config

Read `00_config/board.md` and `00_config/context.md` to see what's already configured. If values are already set, show them and ask if the user wants to update.

## Step 2 — Vault path

Ask: "What is the path to your Obsidian vault? This is where the board reads your business data from. Example: `/Users/you/Documents/my-vault`"

Validate the path exists using `ls`. If it doesn't exist, tell the user and ask again.

Once validated, do a quick scan of the vault to show the user what the board will have access to:

```bash
find {vault_path} -name "*.md" -not -path "*/.obsidian/*" -not -path "*/.git/*" | wc -l
```

Report: "Found {N} markdown files in your vault. The board will search these for relevant context when you ask questions."

Update `vault_path` in `00_config/board.md`.

## Step 3 — Auto-detect connected services

Probe each MCP service to determine which are actually connected. Do this silently — don't ask the user to configure anything, just test each one:

### Gmail
Try calling `mcp__claude_ai_Gmail__list_labels`. 
- If it succeeds: Gmail is connected. Report: "Gmail — connected (will search recent threads for context)"
- If it fails or tool is unavailable: Report: "Gmail — not connected"

### Google Calendar
Try calling `mcp__claude_ai_Google_Calendar__list_calendars`.
- If it succeeds: Calendar is connected. Report: "Google Calendar — connected (will check upcoming events for context)"
- If it fails: Report: "Google Calendar — not connected"

### Google Drive
Try calling `mcp__claude_ai_Google_Drive__list_recent_files`.
- If it succeeds: Drive is connected. Report: "Google Drive — connected (will search docs and spreadsheets for context)"
- If it fails: Report: "Google Drive — not connected"

### Notion
Try calling `mcp__claude_ai_Notion__notion-get-teams`.
- If it succeeds: Notion is connected. Report: "Notion — connected (will search pages and databases for context)"
- If it fails: Report: "Notion — not connected"

### Web Search
Try a test `WebSearch` for "test".
- If it succeeds: Report: "Web Search — available (will search for market data and competitor info)"
- If it fails: Report: "Web Search — not available"

Present the results as a status table:

```
Data Sources:

  Obsidian Vault   ✓  {vault_path} ({N} files)
  Gmail            ✓  connected
  Google Calendar  ✓  connected
  Google Drive     ✗  not connected
  Notion           ✗  not connected
  Web Search       ✓  available
```

For any service that is NOT connected, briefly explain how to connect it:

"To connect additional services, enable them in Claude Code:
- **Gmail / Calendar / Drive**: Go to claude.ai/code → Settings → Connected Apps → connect your Google account
- **Notion**: Go to claude.ai/code → Settings → Connected Apps → connect Notion

You can re-run `/setup` anytime after connecting new services."

Update the enabled flags in `00_config/board.md` based on what actually responded. Only set `true` for services that successfully responded.

## Step 4 — Business context

Tell the user: "Now let's give the board context about your business. The more specific you are, the more actionable the advice. Answer each question — you can always update these later in `00_config/context.md`."

Ask these questions one at a time. Wait for each answer before asking the next:

1. "What is your company/project name and what does it do? (One sentence)"
2. "What stage are you at? (idea / pre-revenue / post-revenue / scaling / mature)"
3. "What is your revenue model?"
4. "How big is your team?"
5. "What are your top 3 priorities right now?"
6. "What keeps you up at night?"
7. "Any key numbers you want the board to know? (Revenue, runway, growth rate, customer count, etc.)"
8. "Who are your main competitors and what's your differentiation?"

Write all answers to `00_config/context.md`, preserving the existing structure and filling in the fields.

## Step 5 — Board composition

Show the full board:

| # | Advisor | Domain |
|---|---------|--------|
| 01 | Steve Jobs | Innovation & Product |
| 02 | Warren Buffett | Finance & M&A |
| 03 | David Ogilvy | Media & Advertising |
| 04 | Andrew Grove | Management & Org |
| 05 | MrBeast | Creativity & Attention |
| 06 | Dalai Lama | Moral & Wisdom |
| 07 | Sun Tzu | Strategy & Special Situations |
| 08 | Harvey Specter | Negotiation & Special Situations |
| 09 | Alex Hormozi | Sales & Offer Design |

Ask: "All 9 advisors are active by default. Do you want to deactivate any? (You can change this anytime by editing `00_config/board.md`)"

Update active flags if needed.

## Step 6 — Confirmation

Output a full summary:

```
Setup complete!

  Company:        {name}
  Stage:          {stage}
  Team:           {size}
  Vault:          {path} ({N} files)
  Data sources:   {list of connected sources}
  Active advisors: {count}/9

Try your first board session:
  /ask hormozi How should we price our product?
  /convene-board Should we raise funding or bootstrap?
  /strategic-review
```
