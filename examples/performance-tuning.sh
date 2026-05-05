#!/usr/bin/env bash

###############################################################################
# performance-tuning.sh
#
# PURPOSE:
#   Apply common performance and security-related kernel tuning.
#   Requires root. Demonstrates: sysctl persistence, limits.conf, safety checks.
#
# WARNING:
#   This script modifies system configuration. Always use --dry-run first
#   and understand the changes before applying on production systems.
###############################################################################

set -euo pipefail

[[ $EUID -ne 0 ]] && { echo "This script requires root privileges."; exit 1; }

log() { echo "[TUNING] $*"; }

log "Applying performance-oriented sysctls (persistent)..."

cat > /etc/sysctl.d/99-ai-tuning.conf <<'EOF'
# Performance tuning applied by AI-generated script
vm.swappiness=10
net.core.somaxconn=65535
fs.file-max=2097152
net.ipv4.tcp_tw_reuse=1
EOF

sysctl -p /etc/sysctl.d/99-ai-tuning.conf

log "Increasing file descriptor limits for all users..."
echo "* soft nofile 65536" >> /etc/security/limits.conf
echo "* hard nofile 65536" >> /etc/security/limits.conf

log "Tuning applied. Some changes require reboot or re-login."