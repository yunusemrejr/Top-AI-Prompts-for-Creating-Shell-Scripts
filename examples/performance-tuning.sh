#!/usr/bin/env bash

set -euo pipefail

# Performance & kernel tuning (sysctl, limits, I/O)
[[ $EUID -ne 0 ]] && { echo "Root required"; exit 1; }

log() { echo "[TUNING] $*"; }

log "Applying performance sysctls..."
cat >> /etc/sysctl.d/99-performance.conf <<EOF
vm.swappiness=10
net.core.somaxconn=65535
fs.file-max=2097152
EOF
sysctl -p /etc/sysctl.d/99-performance.conf

log "Increasing file descriptor limits..."
echo "* soft nofile 65536" >> /etc/security/limits.conf
echo "* hard nofile 65536" >> /etc/security/limits.conf

log "Done. Reboot or re-login for limits to take full effect."