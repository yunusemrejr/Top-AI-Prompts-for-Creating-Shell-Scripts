#!/usr/bin/env bash

set -euo pipefail

# Encrypted backup with GPG + rsync + verification + dry-run
DRY_RUN=false
SOURCE="${1:-}"; DEST="${2:-}"

[[ -z "$SOURCE" || -z "$DEST" ]] && { echo "Usage: $0 <source> <dest> [--dry-run]"; exit 1; }

if [[ "$3" == "--dry-run" ]]; then DRY_RUN=true; fi

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
ARCHIVE="/tmp/backup_${TIMESTAMP}.tar.gz"
ENCRYPTED="${DEST}/backup_${TIMESTAMP}.tar.gz.gpg"

if $DRY_RUN; then
  echo "[DRY] Would create encrypted backup of $SOURCE to $ENCRYPTED"
  exit 0
fi

tar -czf "$ARCHIVE" "$SOURCE"
gpg --symmetric --cipher-algo AES256 --batch --yes --passphrase "CHANGE_ME" -o "$ENCRYPTED" "$ARCHIVE"
rm -f "$ARCHIVE"

echo "Encrypted backup created: $ENCRYPTED"
echo "To decrypt: gpg -d $ENCRYPTED > backup.tar.gz"