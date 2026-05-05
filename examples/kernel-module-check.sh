#!/usr/bin/env bash

###############################################################################
# kernel-module-check.sh
# Deep kernel inspection: modules, parameters, sysctls, security settings
# Usage: ./kernel-module-check.sh [--json] [--security]
###############################################################################

set -euo pipefail

log() { echo -e "\033[0;32m[INFO]\033[0m $*"; }

JSON=false
SECURITY=false

while [[ $# -gt 0 ]]; do
  case $1 in
    --json) JSON=true; shift ;;
    --security) SECURITY=true; shift ;;
    *) echo "Unknown: $1"; exit 1 ;;
  esac
done

KERNEL=$(uname -r)
log "Kernel: $KERNEL"

if $JSON; then
  echo '{"kernel":"'"$KERNEL"'"}'
else
  echo "=== Loaded Modules (first 15) ==="
  lsmod | head -15
  echo "=== Key Sysctls (security & randomness) ==="
  sysctl -a 2>/dev/null | grep -E 'randomize|protect|exec|kptr' | head -10 || true
  if $SECURITY; then
    echo "=== Security-Related Kernel Params ==="
    sysctl kernel.kptr_restrict kernel.dmesg_restrict kernel.unprivileged_userns_clone 2>/dev/null || true
  fi
fi

log "For module management use: modprobe, lsmod, modinfo"