#!/bin/bash

set -euo pipefail

# Advanced: Log analysis for Linux systems (journalctl + traditional logs)

LOG_DIR="/var/log"

# Journalctl for systemd
echo "Recent critical logs:"
journalctl -p err -b -n 50 --no-pager || true

# Traditional logs
if [[ -d "$LOG_DIR" ]]; then
    find "$LOG_DIR" -name "*.log" -mtime -1 | head -5 | xargs tail -n 20 2>/dev/null || true
fi

echo "Use logrotate for management."