#!/usr/bin/env bash

###############################################################################
# firewall-manager.sh
#
# PURPOSE:
#   Unified interface for ufw and firewalld. Shows how to write
#   distro-aware scripts that work across common Linux firewall tools.
#
# EDUCATIONAL VALUE:
#   Demonstrates conditional logic based on available commands,
#   safe argument handling, and clear output. Good example of abstraction.
###############################################################################

set -euo pipefail

log() { echo -e "\033[0;32m[INFO]\033[0m $*"; }

if command -v ufw &>/dev/null; then
  log "Using ufw backend"
  case ${1:-status} in
    status) ufw status verbose ;;
    allow) ufw allow "$2" ;;
    deny) ufw deny "$2" ;;
    reload) ufw reload ;;
    *) echo "ufw commands: status | allow <port> | deny <port> | reload" ;;
  esac
elif command -v firewall-cmd &>/dev/null; then
  log "Using firewalld backend"
  case ${1:-status} in
    status) firewall-cmd --state; firewall-cmd --list-all ;;
    allow) firewall-cmd --add-port="${2}/tcp" --permanent && firewall-cmd --reload ;;
    *) echo "firewalld commands: status | allow <port> | ..." ;;
  esac
else
  echo "No supported firewall found (ufw or firewalld)"
  exit 1
fi
