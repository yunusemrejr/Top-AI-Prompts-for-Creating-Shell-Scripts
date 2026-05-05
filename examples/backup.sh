# Example Shell Script: Backup Utility

#!/bin/bash

set -euo pipefail

# Backup script with timestamp

BACKUP_DIR="~/backups"
SOURCE_DIR="~/important-files"

mkdir -p "$BACKUP_DIR"

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="$BACKUP_DIR/backup_$TIMESTAMP.tar.gz"

tar -czf "$BACKUP_FILE" "$SOURCE_DIR"

echo "Backup created: $BACKUP_FILE"

# Keep only last 7 backups
find "$BACKUP_DIR" -name "backup_*.tar.gz" -mtime +7 -delete