---
description: Interactive configuration — set your vault path, data sources, business context, and active advisors
argument-hint: (no arguments needed)
allowed-tools: [Read, Write, Edit, Bash]
---

# Setup

Walk the user through configuring their board of advisors. This is a guided conversation — ask each section, confirm, then write.

## Step 1 — Read current config

Read `00_config/board.md` and `00_config/context.md` to see what's already configured. If values are already set, show them and ask if the user wants to update.

## Step 2 — Vault path

Ask: "What is the path to your Obsidian vault? This is where the board reads your business data from. Example: `/Users/you/Documents/my-vault`"

Validate the path exists using `ls`. If it doesn't exist, tell the user and ask again.

Update `vault_path` in `00_config/board.md`.

## Step 3 — Connected services

Show the available data sources:

| Source | What it provides |
|---|---|
| Google Drive | Shared docs, spreadsheets, slide decks |
| Notion | Wikis, databases, project trackers |
| Gmail | Recent correspondence, deal threads |
| Google Calendar | Upcoming commitments, availability |
| Web Search | Current market data, competitor info |

Ask: "Which of these do you want to enable? (Web search is on by default. The others require MCP servers to be connected.)"

Update the enabled flags in `00_config/board.md`.

## Step 4 — Business context

Ask these questions one at a time. Wait for each answer before asking the next:

1. "What is your company/project name and what does it do? (One sentence)"
2. "What stage are you at? (idea / pre-revenue / post-revenue / scaling / mature)"
3. "What is your revenue model?"
4. "How big is your team?"
5. "What are your top 3 priorities right now?"
6. "What keeps you up at night?"
7. "Any key numbers you want the board to know? (Revenue, runway, growth rate, customer count, etc.)"
8. "Who are your main competitors and what's your differentiation?"

Write all answers to `00_config/context.md`, preserving the existing structure.

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

Output a summary of the configuration. Then suggest:

"Setup complete. Try your first board session:
- `/ask hormozi How should we price our product?`
- `/convene-board Should we raise funding or bootstrap?`
- `/strategic-review`"
