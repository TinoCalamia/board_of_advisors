---
description: Run a risk analysis on a specific topic from all advisor perspectives — each advisor identifies risks through their unique lens, produces a risk matrix
argument-hint: <topic to scan, e.g. "entering the US market", "raising Series A", "hiring a sales team">
allowed-tools: [Read, Write, Edit, Glob, Bash, WebSearch, WebFetch, mcp__claude_ai_Google_Drive__search_files, mcp__claude_ai_Google_Drive__read_file_content, mcp__claude_ai_Notion__notion-search, mcp__claude_ai_Notion__notion-fetch, mcp__claude_ai_Gmail__search_threads, mcp__claude_ai_Gmail__get_thread, mcp__claude_ai_Google_Calendar__list_events]
---

# Risk Scan

Every advisor focuses exclusively on risks for a specific topic. No opportunities, no silver linings — pure risk identification. The synthesis produces a risk matrix.

## Input

The user provided: $ARGUMENTS

If no topic was provided, ask for one. Good risk scan topics are specific decisions or initiatives: "hiring a CTO", "raising Series A", "launching in Germany", "switching from freemium to paid."

## Step 1 — Load context

1. Read `00_config/board.md` for active advisors and data sources
2. Dispatch `context-loader` with: "Risk analysis of: {topic}. Gather all context relevant to evaluating the risks of this decision."

## Step 2 — Dispatch advisors (risk-only mode)

Dispatch ALL active advisors in parallel. Each gets a modified prompt:

"Analyze the risks of **{topic}** for this business. Focus ONLY on:
- What could go wrong
- What is being overlooked
- What hidden costs or consequences exist
- What must be true for this to succeed (and whether those conditions hold)

Do NOT discuss opportunities or upside. Your job right now is to find the dangers.

Business context: {context from Step 1}"

Each advisor applies their frameworks to identify risks through their unique lens.

## Step 3 — Synthesize as risk matrix

Dispatch `board-synthesizer` with all responses and this additional instruction:

"Produce a risk-focused synthesis in this format:

```
# Risk Scan — {Topic} — {Date}

## Risk Matrix

| # | Risk | Severity | Likelihood | Surfaced by | Mitigation |
|---|------|----------|------------|-------------|------------|
| 1 | {risk} | High/Med/Low | High/Med/Low | {advisor} | {one-line mitigation} |
| ... | | | | | |

## Top 3 Risks (Consensus)
{Risks that multiple advisors independently identified — these are the most real}

## Contrarian Risk
{A risk only one advisor saw but that deserves attention. Explain why it matters.}

## Prerequisites for Success
{What MUST be true for {topic} to work. If any of these conditions fail, the initiative fails.}

## Recommendation
{Given the risk profile: proceed, proceed with caution, or reconsider? One paragraph.}
```"

## Step 4 — Record and output

Save to `02_sessions/{YYYY-MM-DD}-risk-scan-{slug}.md` with `session-type: risk-scan`.

Display the risk matrix and synthesis. Highlight the top 3 consensus risks prominently.
