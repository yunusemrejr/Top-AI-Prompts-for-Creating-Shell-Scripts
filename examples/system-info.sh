#!/usr/bin/env bash

###############################################################################
# system-info.sh
# Advanced system and kernel information gatherer
# Features: colored output, JSON option, extensive checks, logging
# Usage: ./system-info.sh [--json] [--verbose]
###############################################################################

set -euo pipefail

# Color definitions
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'

log() { echo -e "${GREEN}[INFO]${NC} $*"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $*" >&2; }
error() { echo -e "${RED}[ERROR]${NC} $*" >&2; }

usage() {
  cat <<EOF
Usage: $0 [OPTIONS]

Options:
  --json      Output in JSON format (machine readable)
  --verbose   Show more detailed kernel and hardware info
  -h, --help  Show this help

Examples:
  $0
  $0 --json | jq .
  $0 --verbose
EOF
}

JSON_MODE=false
VERBOSE=false

while [[ $# -gt 0 ]]; do
  case $1 in
    --json) JSON_MODE=true; shift ;;
    --verbose) VERBOSE=true; shift ;;
    -h|--help) usage; exit 0 ;;
    *) error "Unknown option: $1"; usage; exit 1 ;;
  esac
done

# Dependency check
for cmd in uname hostnamectl lscpu free df lsblk; do
  if ! command -v "$cmd" &>/dev/null; then
    warn "Optional command missing: $cmd (some info may be limited)"
  fi
done

collect_info() {
  local hostname os kernel arch cpu mem disk
  hostname=$(hostname)
  os=$(grep PRETTY_NAME /etc/os-release 2>/dev/null | cut -d= -f2 | tr -d '"' || echo "Unknown")
  kernel=$(uname -r)
  arch=$(uname -m)

  if $JSON_MODE; then
    echo '{"hostname":"'"$hostname"'","os":"'"$os"'","kernel":"'"$kernel"'","arch":"'"$arch"'"}'
  else
    echo "=== System Information ==="
    echo "Hostname : $hostname"
    echo "OS       : $os"
    echo "Kernel   : $kernel"
    echo "Arch     : $arch"
    echo
    if $VERBOSE; then
      echo "=== Detailed Kernel ==="
      uname -a || true
      echo "=== CPU ==="
      lscpu 2>/dev/null | head -10 || true
      echo "=== Memory ==="
      free -h
      echo "=== Disk ==="
      df -h /
      lsblk 2>/dev/null | head -5 || true
    fi
  fi
}

main() {
  log "Collecting system information..."
  collect_info
  log "Done."
}

main "$@"
