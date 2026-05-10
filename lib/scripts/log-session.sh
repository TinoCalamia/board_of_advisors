#!/bin/bash
# PostToolUse hook: logs file changes during board sessions
# Triggered after every Edit/Write. Skips non-content directories.

set -euo pipefail

EVENT=$(cat)

FILE_PATH=$(echo "$EVENT" | grep -o '"file_path":"[^"]*"' | head -1 | cut -d'"' -f4)

if [ -z "$FILE_PATH" ]; then
  exit 0
fi

# Skip non-content directories
case "$FILE_PATH" in
  */dashboards/*|*/templates/*|*/.claude/*|*/.obsidian/*|*/.git/*|*/lib/scripts/*)
    exit 0
    ;;
esac

# Find the most recent session file
TODAY=$(date +%Y-%m-%d)
SESSION_DIR="02_sessions"

if [ ! -d "$SESSION_DIR" ]; then
  exit 0
fi

LATEST_SESSION=$(find "$SESSION_DIR" -name "${TODAY}*.md" -not -name "_template.md" | sort -r | head -1)

if [ -z "$LATEST_SESSION" ]; then
  exit 0
fi

TIMESTAMP=$(date +%H:%M)
BASENAME=$(basename "$FILE_PATH")
echo "- ${TIMESTAMP} — Updated \`${BASENAME}\`" >> "$LATEST_SESSION"
