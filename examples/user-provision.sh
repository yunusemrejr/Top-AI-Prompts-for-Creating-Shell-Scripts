#!/usr/bin/env bash

###############################################################################
# user-provision.sh
#
# PURPOSE:
#   Simple idempotent user creation example.
#   Shows the pattern: check if exists -> act or skip.
#   This pattern is fundamental for idempotent infrastructure-as-code style scripts.
###############################################################################

set -euo pipefail

USER_NAME="${1:-}"
[[ -z "$USER_NAME" ]] && { echo "Usage: $0 <username>"; exit 1; }

if id "$USER_NAME" &>/dev/null; then
  echo "User '$USER_NAME' already exists. Nothing to do (idempotent)."
else
  useradd -m -s /bin/bash "$USER_NAME"
  echo "User '$USER_NAME' created successfully."
fi
