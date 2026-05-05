#!/usr/bin/env bash

###############################################################################
# service-manager.sh
#
# PURPOSE:
#   Clean wrapper around systemctl for common service operations.
#   Demonstrates case statement for subcommands and clear usage.
###############################################################################

set -euo pipefail

SERVICE="${1:-}"
ACTION="${2:-status}"

[[ -z "$SERVICE" ]] && { echo "Usage: $0 <service> [start|stop|restart|status|logs]"; exit 1; }

case $ACTION in
  start|stop|restart)
    systemctl "$ACTION" "$SERVICE"
    ;;
  status)
    systemctl status "$SERVICE" --no-pager
    ;;
  logs)
    journalctl -u "$SERVICE" -f
    ;;
  *)
    echo "Unknown action: $ACTION"
    exit 1
    ;;
esac
