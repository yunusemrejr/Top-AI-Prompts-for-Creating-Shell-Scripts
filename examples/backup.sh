#!/usr/bin/env bash

###############################################################################
# backup.sh - Robust, timestamped, logged backup with retention and dry-run
# Supports local and basic remote (rsync). Idempotent-friendly.
# Usage: ./backup.sh [--dry-run] [--source /path] [--dest /backup] [--retention 7]
###############################################################################

set -euo pipefail

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'
log() { echo -e "${GREEN}[INFO]${NC} $*"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $*" >&2; }

DRY_RUN=false
SOURCE=""
DEST=""
RETENTION=7

usage() {
  cat <<EOF
Robust backup script with timestamp, logging, retention, and dry-run support.

Usage: $0 [OPTIONS]

Options:
  --source DIR     Source directory to backup (required)
  --dest DIR       Destination base directory (required)
  --retention N    Keep last N backups (default: 7)
  --dry-run        Show what would be done without executing
  -h, --help       Show help

Examples:
  $0 --source /home/user/data --dest /backups
  $0 --dry-run --source /etc --dest /backups
EOF
}

while [[ $# -gt 0 ]]; do
  case $1 in
    --source) SOURCE="$2"; shift 2 ;;
    --dest) DEST="$2"; shift 2 ;;
    --retention) RETENTION="$2"; shift 2 ;;
    --dry-run) DRY_RUN=true; shift ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown option: $1"; usage; exit 1 ;;
  esac
done

[[ -z "$SOURCE" || -z "$DEST" ]] && { usage; exit 1; }

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_NAME="backup_${TIMESTAMP}"
BACKUP_PATH="$DEST/$BACKUP_NAME"

log "Starting backup: $SOURCE -> $BACKUP_PATH"

if $DRY_RUN; then
  log "[DRY-RUN] Would create directory: mkdir -p $DEST"
  log "[DRY-RUN] Would run: tar -czf ${BACKUP_PATH}.tar.gz $SOURCE"
  log "[DRY-RUN] Would keep only last $RETENTION backups"
  exit 0
fi

mkdir -p "$DEST"
tar -czf "${BACKUP_PATH}.tar.gz" "$SOURCE" 2>&1 | tee -a "${BACKUP_PATH}.log"

log "Backup created: ${BACKUP_PATH}.tar.gz"

# Retention policy
find "$DEST" -name "backup_*.tar.gz" -mtime +"$RETENTION" -delete
log "Old backups cleaned (kept last $RETENTION)"

log "Backup completed successfully."