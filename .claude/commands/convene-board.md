---
description: Convene the full board of advisors on a strategic question — all active advisors respond in parallel, then a synthesizer produces INSIGHTS / RISKS / OPTIONS / RECOMMENDATION
argument-hint: <strategic question>
allowed-tools: [Read, Write, Edit, Glob, Bash, WebSearch, WebFetch, mcp__claude_ai_Google_Drive__search_files, mcp__claude_ai_Google_Drive__read_file_content, mcp__claude_ai_Notion__notion-search, mcp__claude_ai_Notion__notion-fetch, mcp__claude_ai_Gmail__search_threads, mcp__claude_ai_Gmail__get_thread, mcp__claude_ai_Google_Calendar__list_events]
---

# Convene the Board

This is the flagship skill. Dispatches all active advisors in parallel on a strategic question, collects their perspectives, and synthesizes a final recommendation.

## Input

The user provided: $ARGUMENTS

If no question was provided, ask for one. The question should be strategic and open-ended — not a yes/no question. If the user gives a yes/no question, reframe it as an open-ended strategic question and confirm.

## Step 1 — Load configuration

1. Read `00_config/.vault-path` to get the vault path. If the file does not exist, tell the user: "No vault configured. Run `/setup` first to connect your Obsidian vault." and stop.
2. Read `{vault_path}/board/config/board.md` to determine:
   - Which advisors are active
   - Which data sources are enabled
   - Session defaults (max words, save preference)
3. Read `{vault_path}/board/config/context.md` for the business overview

## Step 2 — Gather context

Dispatch the `context-loader` subagent with:
- The question
- The board configuration (vault path, enabled sources)

It returns a compressed business context summary (max 500 words).

## Step 3 — Dispatch advisors

For each active advisor in `board.md`, dispatch the corresponding subagent. Pass each:
- The strategic question
- The business context from Step 2

**Run ALL advisor subagents IN PARALLEL** — do not dispatch them sequentially. Fire all of them in a single message with multiple Agent tool calls.

Each advisor returns their perspective in their unique format (max 300 words each).

## Step 4 — Synthesize

Dispatch the `board-synthesizer` subagent. Pass it:
- The original question
- The business context summary
- ALL advisor responses collected from Step 3

It returns the structured synthesis: INSIGHTS | RISKS | OPTIONS | RECOMMENDATION | DISSENT.

## Step 5 — Record the session

If `save_sessions` is true in board config, write the full session to `{vault_path}/board/sessions/{YYYY-MM-DD}-{slug}.md`:

```yaml
---
type: session
date: {today YYYY-MM-DD}
session-type: full-board
question: "{question}"
advisors: [{list of active advisor slugs}]
topics: [{inferred topic tags}]
---
```

Then the full content:
1. The question
2. The business context summary
3. Each advisor's response (in order)
4. The full synthesis

## Step 6 — Output

Display the synthesis to the user. Format it cleanly with headers.

Then note: "Full session saved to `board/sessions/{filename}` in your vault" and list which advisors participated.

If any advisor's perspective was particularly strong or contrarian, highlight it: "Notable: {Advisor} raised a point worth deeper exploration."
