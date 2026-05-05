#!/usr/bin/env bash

###############################################################################
# system-info.sh
#
# PURPOSE:
#   Advanced, production-ready system and kernel information gatherer.
#   Demonstrates: colored logging, optional JSON output, extensive checks,
#   dependency handling, educational comments, and clean argument parsing.
#
# WHY THIS SCRIPT EXISTS:
#   Many AI-generated system info scripts are minimal and fragile.
#   This version shows what a high-quality, well-documented AI output looks like
#   when the prompt includes all the mandatory best practices.
#
# EDUCATIONAL VALUE:
#   Study the comments to understand why each pattern is used.
#   This script is intentionally verbose in comments to teach best practices.
#
# USAGE:
#   ./system-info.sh [--json] [--verbose] [--help]
#
# REQUIREMENTS:
#   - Bash 4+
#   - Standard Linux tools (uname, hostname, etc.)
#   - Optional: lscpu, free, df, lsblk for richer output
###############################################################################

set -euo pipefail

# ---------------------------------------------------------------------------
# COLOR AND LOGGING SETUP
# Why we define these: Consistent, readable output across different terminals.
# Using tput would be more portable but ANSI codes are widely supported.
# ---------------------------------------------------------------------------
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log() { echo -e "${GREEN}[INFO]${NC} $*"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $*" >&2; }
error() { echo -e "${RED}[ERROR]${NC} $*" >&2; exit 1; }

# ---------------------------------------------------------------------------
# USAGE / HELP FUNCTION
# Why: Every production script should be self-documenting.
# This allows users (and future AI) to understand the script without reading code.
# ---------------------------------------------------------------------------
usage() {
  cat <<EOF
Usage: $0 [OPTIONS]

Advanced system information gatherer with JSON and verbose modes.

Options:
  --json      Output machine-readable JSON (for scripting/monitoring)
  --verbose   Show detailed CPU, memory, disk, and kernel information
  -h, --help  Show this help message

Examples:
  $0
  $0 --json | jq .
  $0 --verbose
EOF
}

# ---------------------------------------------------------------------------
# ARGUMENT PARSING
# Why getopts-style + case: Clear, extensible, and handles --long options cleanly.
# We avoid getopts here for simplicity with long options; production scripts
# often use getopts or a small argument parser library.
# ---------------------------------------------------------------------------
JSON_MODE=false
VERBOSE=false

while [[ $# -gt 0 ]]; do
  case $1 in
    --json)
      JSON_MODE=true
      shift
      ;;
    --verbose)
      VERBOSE=true
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      error "Unknown option: $1. Use --help for usage."
      ;;
  esac
done

# ---------------------------------------------------------------------------
# DEPENDENCY CHECKING
# Why: Fail early with helpful messages instead of cryptic command-not-found errors.
# This is a key production pattern that many AI outputs miss.
# ---------------------------------------------------------------------------
check_dependency() {
  if ! command -v "$1" &>/dev/null; then
    warn "Optional dependency missing: $1 (some output will be limited)"
  fi
}

check_dependency uname
check_dependency hostnamectl
check_dependency lscpu
check_dependency free
check_dependency df
check_dependency lsblk

# ---------------------------------------------------------------------------
# MAIN INFORMATION COLLECTION
# Why separate function: Improves readability and allows future extension
# (e.g., adding more collectors for GPU, network, etc.).
# ---------------------------------------------------------------------------
collect_info() {
  local hostname os kernel arch

  hostname=$(hostname)
  os=$(grep PRETTY_NAME /etc/os-release 2>/dev/null | cut -d= -f2 | tr -d '"' || echo "Unknown OS")
  kernel=$(uname -r)
  arch=$(uname -m)

  if $JSON_MODE; then
    # JSON output for machine consumption (monitoring, automation)
    printf '{"hostname":"%s","os":"%s","kernel":"%s","arch":"%s"}\n' \
      "$hostname" "$os" "$kernel" "$arch"
  else
    echo "=== System Information ==="
    echo "Hostname : $hostname"
    echo "OS       : $os"
    echo "Kernel   : $kernel"
    echo "Architecture: $arch"
    echo

    if $VERBOSE; then
      echo "=== Detailed Kernel Information ==="
      uname -a || true
      echo
      echo "=== CPU Information ==="
      lscpu 2>/dev/null | head -12 || true
      echo
      echo "=== Memory Information ==="
      free -h
      echo
      echo "=== Disk Information ==="
      df -h /
      lsblk 2>/dev/null | head -8 || true
    fi
  fi
}

# ---------------------------------------------------------------------------
# MAIN ENTRY POINT
# Why: Keeps the top level clean and makes the script easier to test.
# ---------------------------------------------------------------------------
main() {
  log "Collecting system information..."
  collect_info
  log "Collection complete."
}

main "$@"
