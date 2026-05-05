#!/usr/bin/env bash

###############################################################################
# firewall-manager.sh - Unified firewall management for ufw / firewalld
# Usage: ./firewall-manager.sh status | allow 22 | deny 23 | reload
###############################################################################

set -euo pipefail

if command -v ufw &>/dev/null; then
  case ${1:-status} in
    status) ufw status verbose ;;
    allow) ufw allow "$2" ;;
    deny) ufw deny "$2" ;;
    reload) ufw reload ;;
    *) echo "ufw mode: status|allow|deny|reload" ;;
  esac
elif command -v firewall-cmd &>/dev/null; then
  case ${1:-status} in
    status) firewall-cmd --state; firewall-cmd --list-all ;;
    allow) firewall-cmd --add-port="${2}/tcp" --permanent ;;
    *) echo "firewalld mode" ;;
  esac
else
  echo "No supported firewall found (ufw or firewalld)"
  exit 1
fi