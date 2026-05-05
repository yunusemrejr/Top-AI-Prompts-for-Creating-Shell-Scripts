#!/bin/bash

set -euo pipefail

# Advanced Linux security: SSH hardening (Debian/Ubuntu/RHEL compatible)

SSH_CONFIG="/etc/ssh/sshd_config"
BACKUP="${SSH_CONFIG}.bak.$(date +%s)"

if [[ $EUID -ne 0 ]]; then
    echo "Run as root."
    exit 1
fi

cp "$SSH_CONFIG" "$BACKUP"
echo "Backup created: $BACKUP"

# Apply best practices
sed -i 's/#PermitRootLogin.*/PermitRootLogin no/' "$SSH_CONFIG"
sed -i 's/#PasswordAuthentication.*/PasswordAuthentication no/' "$SSH_CONFIG"
sed -i 's/#PubkeyAuthentication.*/PubkeyAuthentication yes/' "$SSH_CONFIG"

# Add if not present
if ! grep -q "PermitRootLogin" "$SSH_CONFIG"; then
    echo "PermitRootLogin no" >> "$SSH_CONFIG"
fi

echo "Restarting SSH: systemctl restart sshd"
systemctl restart sshd

echo "SSH hardened. Test connection before closing session!"