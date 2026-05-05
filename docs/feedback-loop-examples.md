# Feedback Loops: How to Effectively Iterate with AI Agents on Shell Scripts

## Why Feedback Loops Matter

Even the best initial prompt rarely produces a perfect script on the first try. Professional results come from **iterative refinement** — giving the AI specific, constructive feedback and asking it to improve the previous output.

This document shows:

1. An example of a **mediocre / typical first output** from an AI
2. **Constructive feedback** you can give
3. The **improved second version**
4. The pattern you can reuse for any script

## Example 1: Backup Script — Initial Mediocre Output

**User's first prompt:** "Write a bash script that backs up a directory."

**Typical AI first output (abbreviated):**

```bash
#!/bin/bash
SOURCE=$1
DEST=$2
tar -czf $DEST/backup.tar.gz $SOURCE
echo "Backup done"
```

**Problems with this output:**
- No strict mode
- No error handling
- No quoting of variables (dangerous!)
- No input validation
- No logging
- No dry-run
- No help function
- No comments
- Hardcoded backup name (will overwrite)
- No retention policy

## Constructive Feedback (What You Should Actually Send)

```
Improve the previous backup script with the following changes:

1. Add set -euo pipefail and a trap for cleanup.
2. Add proper input validation and a usage/help function.
3. Quote all variables properly.
4. Add a --dry-run flag that shows what would happen without executing.
5. Add timestamped backup names and a retention policy (keep last 7).
6. Add logging to both stdout (with colors) and a log file.
7. Add extensive comments explaining WHY each section exists.
8. Make the script idempotent-friendly.
9. Add dependency checks.

After making these changes, output ONLY the complete improved script in one code block.
```

## Improved Second Version (What Good AI Output Looks Like)

```bash
#!/usr/bin/env bash

###############################################################################
# backup.sh - Robust timestamped backup with dry-run, retention, and logging
###############################################################################

set -euo pipefail

# Color and logging setup
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log() { echo -e "${GREEN}[INFO]${NC} $*"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $*" >&2; }
error() { echo -e "${RED}[ERROR]${NC} $*" >&2; exit 1; }

usage() {
  cat <<EOF
Usage: $0 [OPTIONS]

Options:
  --source DIR     Source directory (required)
  --dest DIR       Destination directory (required)
  --retention N    Number of backups to keep (default 7)
  --dry-run        Show actions without executing
  -h, --help       Show this help
EOF
}

# Parse arguments safely
DRY_RUN=false
SOURCE=""
DEST=""
RETENTION=7

while [[ $# -gt 0 ]]; do
  case $1 in
    --source) SOURCE="$2"; shift 2 ;;
    --dest) DEST="$2"; shift 2 ;;
    --retention) RETENTION="$2"; shift 2 ;;
    --dry-run) DRY_RUN=true; shift ;;
    -h|--help) usage; exit 0 ;;
    *) error "Unknown option: $1" ;;
  esac
done

[[ -z "$SOURCE" || -z "$DEST" ]] && { usage; error "Missing required arguments"; }

# Main logic with dry-run support
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_NAME="backup_${TIMESTAMP}.tar.gz"
BACKUP_PATH="$DEST/$BACKUP_NAME"

if $DRY_RUN; then
  log "[DRY-RUN] Would create backup of $SOURCE to $BACKUP_PATH"
  log "[DRY-RUN] Would keep only last $RETENTION backups"
  exit 0
fi

log "Starting backup..."
mkdir -p "$DEST"
tar -czf "$BACKUP_PATH" "$SOURCE" || error "tar failed"

log "Backup created: $BACKUP_PATH"

# Retention (idempotent-friendly)
find "$DEST" -name "backup_*.tar.gz" -mtime +"$RETENTION" -delete
log "Retention policy applied (kept last $RETENTION)"

log "Backup completed successfully."
```

## Example 2: Feedback on Error Handling

**Initial AI output problem:** No trap, script continues after failure.

**Good feedback:**
"Add a trap function that cleans up temporary files on EXIT, ERR, and INT. Also add a cleanup() function that is called by the trap. Make sure the script exits with a non-zero code on any error. Add comments explaining the trap mechanism."

## General Feedback Template You Can Reuse

```
Improve the previous version of the script with these specific changes:

1. [Specific technical improvement + reason]
2. [Another improvement + reason]
3. Add extensive comments explaining the changes and why they matter.

Output ONLY the complete improved script.
```

## Why This Feedback Style Works So Well

- It is **specific** ("add X because Y") rather than vague ("make it better").
- It references the **previous version** so the model has context.
- It asks for **comments explaining the changes** — this makes the model reflect on its own work.
- It limits the number of changes per iteration (2-4 is ideal).
- It ends with clear output format instructions.

Use this pattern and you will reach production-quality scripts in 1-3 iterations instead of many frustrating attempts.

---

**Pro tip:** After 2-3 iterations, ask the model: "Review the final script against the verification checklist in verification-checklist.md and suggest any remaining improvements."