---
description: Full business review from all advisor perspectives — deep vault read, each advisor reviews their domain
argument-hint: (no arguments needed — reads from vault and config)
allowed-tools: [Read, Write, Edit, Glob, Bash, WebSearch, WebFetch, mcp__claude_ai_Google_Drive__search_files, mcp__claude_ai_Google_Drive__read_file_content, mcp__claude_ai_Notion__notion-search, mcp__claude_ai_Notion__notion-fetch, mcp__claude_ai_Gmail__search_threads, mcp__claude_ai_Gmail__get_thread, mcp__claude_ai_Google_Calendar__list_events, mcp__claude_ai_Google_Calendar__list_calendars]
---

# Strategic Review

A comprehensive business assessment. Unlike `/convene-board` (which asks one question), this skill gives each advisor a domain-specific review question and produces a full strategic picture.

## Step 1 — Deep context gathering

Dispatch `context-loader` with a broad mandate: "Comprehensive business review — gather all available context about the company, product, financials, team, marketing, sales, competitors, and recent activity."

The context-loader should do a broad scan across all enabled data sources, returning up to 800 words of context.

## Step 2 — Read business context

Read `00_config/context.md` directly as well, to supplement the context-loader's findings.

## Step 3 — Dispatch advisors with domain-specific questions

Dispatch ALL active advisors in parallel. Instead of one shared question, each advisor gets a domain-specific review prompt:

| Advisor | Review prompt |
|---|---|
| Steve Jobs | "Review this business through your lens: What is the product direction? Where does simplicity demand change? Is the product remarkable or merely adequate?" |
| Warren Buffett | "Review the financial position: What are the unit economics? How strong is the competitive moat? Where is capital being wasted or well-deployed?" |
| David Ogilvy | "Review the brand and marketing: How strong is the messaging and positioning? Is the brand being built or eroded? What would you change about how they communicate?" |
| Andrew Grove | "Review the organization: Is the team structured for the next stage of growth? Where are the process gaps? What strategic inflection point might they be missing?" |
| MrBeast | "Review the distribution and content strategy: How effective is their attention game? Where are they losing people? What would you test to 10x their reach?" |
| Dalai Lama | "Review the purpose and impact: Is the company's mission clear? Are stakeholders being served well? What is the long-term human impact of their work?" |
| Sun Tzu | "Review the competitive position: How defensible is their market position? What threats are approaching? Where are the strategic vulnerabilities?" |
| Harvey Specter | "Review the deal landscape: What partnerships, negotiations, or deals should be on the table? Where is leverage being left unused? What relationships need attention?" |
| Alex Hormozi | "Review the offer and sales engine: Is the offer irresistible? Are they charging enough? What's broken in the lead-to-revenue pipeline?" |

Pass each advisor the full business context from Steps 1-2.

## Step 4 — Synthesize

Dispatch `board-synthesizer` with all responses. The synthesis should be structured as a strategic review:

```
# Strategic Review — {Date}

## COMPANY SNAPSHOT
{One paragraph summary of current state}

## STRENGTHS (consensus across advisors)

## VULNERABILITIES (what multiple advisors flagged)

## OPPORTUNITIES (what advisors see that the company might not)

## RECOMMENDED PRIORITIES
{Top 3 actions, ranked, with the advisor who champions each}

## WATCH LIST
{Emerging risks or inflection points to monitor}
```

## Step 5 — Record and output

Save to `02_sessions/{YYYY-MM-DD}-strategic-review.md` with `session-type: review`.

Display the full synthesis. This is the most comprehensive output the board produces — give it the space it needs.
