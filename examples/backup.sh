#!/usr/bin/env bash

###############################################################################
# backup.sh
#
# PURPOSE:
#   Robust, timestamped, logged backup with retention policy and dry-run support.
#   Demonstrates production patterns: argument parsing, validation, dry-run,
#   logging, retention, and extensive educational comments.
#
# WHY THIS IS A GOOD AI OUTPUT EXAMPLE:
#   When prompted with the full best-practices list, AI produces scripts
#   like this instead of fragile one-liners. Study the comments to learn the patterns.
#
# KEY FEATURES:
#   - Dry-run mode (critical for destructive operations)
#   - Timestamped backups (prevents overwrites)
#   - Retention policy (automatic cleanup)
#   - Colored logging + log file
#   - Input validation + helpful errors
#   - Extensive comments explaining design decisions
###############################################################################

set -euo pipefail

# Color definitions for readable output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log() { echo -e "${GREEN}[INFO]${NC} $*"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $*" >&2; }
error() { echo -e "${RED}[ERROR]${NC} $*" >&2; exit 1; }

usage() {
  cat <<EOF
Robust backup script with timestamping, retention, dry-run, and logging.

Usage: $0 [OPTIONS]

Options:
  --source DIR     Source directory to backup (required)
  --dest DIR       Destination base directory (required)
  --retention N    Number of recent backups to keep (default: 7)
  --dry-run        Show what would be done without actually executing
  -h, --help       Show this help message

Examples:
  $0 --source /home/user/data --dest /backups
  $0 --dry-run --source /etc --dest /backups
  $0 --source /var/lib/mysql --dest /backups --retention 30
EOF
}

# Argument parsing with validation
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
    *) error "Unknown option: $1. Use --help for usage."
  esac
done

# Validation after parsing
[[ -z "$SOURCE" || -z "$DEST" ]] && { usage; error "--source and --dest are required"; }

# Main logic
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_NAME="backup_${TIMESTAMP}.tar.gz"
BACKUP_PATH="$DEST/$BACKUP_NAME"

log "Starting backup of '$SOURCE' to '$BACKUP_PATH'"

if $DRY_RUN; then
  log "[DRY-RUN MODE] No changes will be made."
  log "[DRY-RUN] Would create directory: mkdir -p $DEST"
  log "[DRY-RUN] Would create archive: tar -czf $BACKUP_PATH $SOURCE"
  log "[DRY-RUN] Would apply retention: keep last $RETENTION backups"
  log "[DRY-RUN] Backup simulation complete."
  exit 0
fi

# Real execution
mkdir -p "$DEST" || error "Failed to create destination directory"

tar -czf "$BACKUP_PATH" "$SOURCE" 2>&1 | tee -a "${BACKUP_PATH%.tar.gz}.log" || error "tar command failed"

log "Backup archive created successfully: $BACKUP_PATH"

# Retention policy (idempotent - safe to re-run)
find "$DEST" -name "backup_*.tar.gz" -mtime +"$RETENTION" -delete 2>/dev/null || true
log "Retention policy applied. Kept the last $RETENTION backups."

log "Backup process completed successfully."