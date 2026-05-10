---
description: Ask a single advisor a strategic question — routes to the specific advisor subagent
argument-hint: <advisor name> <question>
allowed-tools: [Read, Glob, Bash, WebSearch, WebFetch, mcp__claude_ai_Google_Drive__search_files, mcp__claude_ai_Google_Drive__read_file_content, mcp__claude_ai_Notion__notion-search, mcp__claude_ai_Notion__notion-fetch, mcp__claude_ai_Gmail__search_threads, mcp__claude_ai_Gmail__get_thread, mcp__claude_ai_Google_Calendar__list_events]
---

# Ask a Single Advisor

Route a question to one specific advisor and return their perspective.

## Input

The user provided: $ARGUMENTS

Parse the first word as the advisor name. Everything after is the question.

## Step 1 — Resolve advisor

Map the input to a valid advisor slug. Accept fuzzy matches:

| Input variants | Resolves to |
|---|---|
| `jobs`, `steve`, `steve-jobs`, `apple` | steve-jobs |
| `buffett`, `warren`, `warren-buffett`, `oracle` | warren-buffett |
| `ogilvy`, `david`, `david-ogilvy` | david-ogilvy |
| `grove`, `andy`, `andrew`, `andrew-grove`, `intel` | andrew-grove |
| `mrbeast`, `beast`, `james`, `jimmy` | mrbeast |
| `dalai`, `dalai-lama`, `lama` | dalai-lama |
| `sun`, `sun-tzu`, `tzu`, `sunzi` | sun-tzu |
| `harvey`, `specter`, `harvey-specter`, `suits` | harvey-specter |
| `hormozi`, `alex`, `alex-hormozi` | alex-hormozi |

If no valid match, list all 9 advisors with their domains and ask the user to choose.

If no question was provided after the advisor name, ask for one.

## Step 2 — Load context

1. Read `00_config/.vault-path` to get the vault path. If the file does not exist, tell the user: "No vault configured. Run `/setup` first to connect your Obsidian vault." and stop.
2. Read `{vault_path}/board/config/board.md` for data source configuration
3. Read `{vault_path}/board/config/context.md` for business overview
4. Dispatch the `context-loader` subagent with the question and board config. It returns a compressed context summary.

## Step 3 — Dispatch advisor

Dispatch the matched advisor subagent. Pass it:
- The question
- The business context from Step 2

The advisor reads its own persona and frameworks files, applies its frameworks, and returns its perspective.

## Step 4 — Output

Display the advisor's response directly. Do not synthesize — this is a single-advisor consultation.

Optionally, suggest: "Want to hear what the full board thinks? Run `/convene-board {question}`"
