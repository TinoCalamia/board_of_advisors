---
description: Have advisors debate a question with opposing views — multi-round with rebuttals before synthesis
argument-hint: <strategic question that has no clear right answer>
allowed-tools: [Read, Write, Edit, Glob, Bash, WebSearch, WebFetch, mcp__claude_ai_Google_Drive__search_files, mcp__claude_ai_Google_Drive__read_file_content, mcp__claude_ai_Notion__notion-search, mcp__claude_ai_Notion__notion-fetch, mcp__claude_ai_Gmail__search_threads, mcp__claude_ai_Gmail__get_thread, mcp__claude_ai_Google_Calendar__list_events]
---

# Board Debate

A structured multi-round debate. Advisors take initial positions, then respond to each other's arguments before synthesis. Use for questions where reasonable people disagree.

## Input

The user provided: $ARGUMENTS

If no question was provided, ask for one. Good debate questions have legitimate arguments on both sides. If the question has an obvious answer, suggest reframing it.

## Step 1 — Load config and context

1. Read `00_config/board.md` for active advisors and data sources
2. Read `00_config/context.md` for business overview
3. Dispatch `context-loader` with the question

## Step 2 — Round 1: Initial positions

Dispatch ALL active advisors in parallel with the question and business context. Each returns their initial perspective using their standard format.

Output to the user: "**Round 1 — Initial Positions**" followed by each advisor's response.

## Step 3 — Identify fault lines

Read all Round 1 responses. Identify the 2-3 biggest **disagreements** across advisors. These are the debate topics.

Output to the user: "**Fault Lines Identified:**" followed by a brief description of each disagreement and which advisors are on which side.

## Step 4 — Round 2: Rebuttals

For each fault line, dispatch the 2-3 advisors who disagree most. This time, include the opposing advisor's Round 1 position in the prompt. Ask each to:
1. Directly address the opposing view
2. Explain why they still disagree (or concede if the argument was convincing)
3. Strengthen their position with additional evidence or reasoning

Run these in parallel where possible.

Output to the user: "**Round 2 — Rebuttals**" followed by each rebuttal.

## Step 5 — Synthesize

Dispatch `board-synthesizer` with ALL Round 1 and Round 2 responses. The synthesis should highlight:
- Where positions **shifted** (an advisor conceded a point)
- Where positions **hardened** (disagreement deepened)
- What the user should take from the debate

## Step 6 — Record and output

Save session with `session-type: debate` to `02_sessions/{YYYY-MM-DD}-debate-{slug}.md`.

Display the full synthesis. Note which fault lines remain unresolved — these are the areas where the user's judgment is most needed.
