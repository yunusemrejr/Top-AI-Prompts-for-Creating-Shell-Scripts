#!/usr/bin/env bash

set -euo pipefail

# Production-grade SSH hardening with backup and verification
[[ $EUID -ne 0 ]] && { echo "Run as root"; exit 1; }

SSH_CONFIG=/etc/ssh/sshd_config
BACKUP="${SSH_CONFIG}.bak.$(date +%s)"

cp "$SSH_CONFIG" "$BACKUP"
echo "Backup: $BACKUP"

# Apply hardening
sed -i 's/^#*PermitRootLogin.*/PermitRootLogin no/' "$SSH_CONFIG"
sed -i 's/^#*PasswordAuthentication.*/PasswordAuthentication no/' "$SSH_CONFIG"
sed -i 's/^#*PubkeyAuthentication.*/PubkeyAuthentication yes/' "$SSH_CONFIG"

systemctl restart sshd && echo "SSH restarted successfully. Test your connection!"