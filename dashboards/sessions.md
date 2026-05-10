---
type: dashboard
last-updated: 2026-05-10
---

# Board Sessions

> [!info] This dashboard works inside your Obsidian vault. `/setup` copies it to `board/dashboards/` automatically.
> Requires the **Dataview** community plugin. Settings -> Community plugins -> Browse -> search "Dataview" -> Install -> Enable.

## Recent Sessions

```dataview
TABLE
  session-type AS "Type",
  question AS "Question",
  advisors AS "Advisors"
FROM "board/sessions"
WHERE type = "session"
SORT date DESC
LIMIT 20
```

## Sessions by Type

```dataview
TABLE
  length(rows) AS "Count"
FROM "board/sessions"
WHERE type = "session"
GROUP BY session-type
```

## This Month

```dataview
LIST question
FROM "board/sessions"
WHERE type = "session" AND date >= date(today) - dur(30 days)
SORT date DESC
```
