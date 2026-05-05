#!/usr/bin/env bash

set -euo pipefail

# systemd service manager wrapper with status and logs
SERVICE="${1:-}"
ACTION="${2:-status}"

[[ -z "$SERVICE" ]] && { echo "Usage: $0 <service> [start|stop|restart|status|logs]"; exit 1; }

case $ACTION in
  start|stop|restart) systemctl "$ACTION" "$SERVICE" ;;
  status) systemctl status "$SERVICE" --no-pager ;;
  logs) journalctl -u "$SERVICE" -f ;;
  *) echo "Unknown action"; exit 1 ;;
 esac