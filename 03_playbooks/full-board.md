---
type: playbook
last-updated: 2026-05-10
---

# Full Board Session — How It Works

## When to Use

Use `/convene-board` when you have a strategic question that benefits from multiple perspectives. Best for decisions where there is no single right answer and the value comes from seeing the tensions between different viewpoints.

Good questions:
- "Should we raise funding or bootstrap?"
- "Should we pivot from B2C to B2B?"
- "Should we hire a VP Sales or build a sales team bottom-up?"

Bad questions (use `/ask` instead):
- "What should our headline be?" -> `/ask ogilvy`
- "How should we structure this deal?" -> `/ask specter`

## The Flow

```
1. You ask a strategic question
   |
2. Context-loader gathers data from vault + connected services
   |
3. All 9 advisors run IN PARALLEL — each reads only its own persona
   |
4. Board-synthesizer collects all 9 perspectives
   |
5. Synthesis: INSIGHTS | RISKS | OPTIONS | RECOMMENDATION | DISSENT
   |
6. Session saved to board/sessions/ in your vault
```

## What You Get

- **INSIGHTS**: 3-5 key observations attributed to the advisor who surfaced them
- **RISKS**: 3-5 risks ranked by severity
- **OPTIONS**: 2-4 distinct strategic paths with tradeoffs
- **RECOMMENDATION**: The board's collective wisdom distilled into one actionable direction
- **DISSENT**: Which advisor(s) disagree and why — often the most valuable section

## Tips

- Be specific in your question. "How should we grow?" is too broad. "Should we double down on content marketing or invest in outbound sales?" gives the board something to work with.
- Fill in your business context thoroughly (run `/setup` or edit `board/config/context.md` in your vault) — the more the board knows about your business, the more specific the advice.
- Read the DISSENT section carefully. The minority view is often the one that prevents a blind spot.
- Run a follow-up `/debate` if a particular tension is worth exploring deeper.
