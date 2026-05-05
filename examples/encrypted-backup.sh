#!/usr/bin/env bash

###############################################################################
# encrypted-backup.sh
#
# PURPOSE:
#   Encrypted backup using GPG + tar with verification, dry-run, and cleanup.
#   Demonstrates: encryption, temp file handling, trap cleanup, verification,
#   and security-conscious patterns.
#
# EDUCATIONAL NOTES:
#   - Uses trap to guarantee temp file removal even on error or interrupt
#   - Dry-run shows exactly what would happen
#   - GPG symmetric encryption for simplicity (can be extended to asymmetric)
#   - Verification step after encryption
#   - All variables quoted
#   - Extensive comments for learning
###############################################################################

set -euo pipefail

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'
log() { echo -e "${GREEN}[INFO]${NC} $*"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $*" >&2; }
error() { echo -e "${RED}[ERROR]${NC} $*" >&2; exit 1; }

usage() {
  cat <<EOF
Encrypted backup with GPG, dry-run, and automatic temp cleanup.

Usage: $0 <source> <dest> [--dry-run]

The backup will be encrypted with AES256. You will be prompted for a passphrase
unless --dry-run is used.
EOF
}

DRY_RUN=false
SOURCE="${1:-}"
DEST="${2:-}"

if [[ "$3" == "--dry-run" ]]; then
  DRY_RUN=true
fi

[[ -z "$SOURCE" || -z "$DEST" ]] && { usage; error "Usage: $0 <source> <dest> [--dry-run]"; }

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
ARCHIVE="/tmp/backup_${TIMESTAMP}.tar.gz"
ENCRYPTED="${DEST}/backup_${TIMESTAMP}.tar.gz.gpg"

# Cleanup trap - guarantees temp file is removed even on error or Ctrl+C
cleanup() {
  rm -f "$ARCHIVE" 2>/dev/null || true
}
trap cleanup EXIT ERR INT TERM

if $DRY_RUN; then
  log "[DRY-RUN] Would create encrypted backup of $SOURCE"
  log "[DRY-RUN] Would write to: $ENCRYPTED"
  log "[DRY-RUN] Temp archive would be cleaned automatically via trap"
  exit 0
fi

log "Creating archive..."
tar -czf "$ARCHIVE" "$SOURCE" || error "Failed to create archive"

log "Encrypting with GPG AES256..."
gpg --symmetric --cipher-algo AES256 --batch --yes --passphrase-fd 0 -o "$ENCRYPTED" "$ARCHIVE" <<< "$(read -s -p 'Enter passphrase: ' pass; echo $pass)" || error "GPG encryption failed"

log "Encrypted backup created: $ENCRYPTED"
log "To decrypt later: gpg -d $ENCRYPTED > backup.tar.gz"

# Verify the encrypted file exists and has size
if [[ -f "$ENCRYPTED" && -s "$ENCRYPTED" ]]; then
  log "Verification: Encrypted file exists and is not empty."
else
  error "Verification failed: Encrypted file missing or empty"
fi
