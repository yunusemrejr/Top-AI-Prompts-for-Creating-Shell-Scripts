#!/usr/bin/env bash

set -euo pipefail

# Idempotent user and group provisioning
USER_NAME="${1:-}"
[[ -z "$USER_NAME" ]] && { echo "Usage: $0 <username>"; exit 1; }

if id "$USER_NAME" &>/dev/null; then
  echo "User $USER_NAME already exists. Skipping."
else
  useradd -m -s /bin/bash "$USER_NAME"
  echo "User $USER_NAME created."
fi

# Example: add to sudo group if needed
# usermod -aG sudo "$USER_NAME"