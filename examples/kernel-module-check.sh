#!/bin/bash

set -euo pipefail

# Advanced example: Check for kernel modules, loaded modules, and version-specific info

KERNEL_VERSION="$(uname -r)"
echo "Kernel version: $KERNEL_VERSION"

# List loaded modules
echo "Loaded kernel modules:"
lsmod | head -20

# Check for specific modules (e.g., for NVIDIA, WiFi)
for module in nvidia iwlmvm; do
    if lsmod | grep -q "^$module"; then
        echo "✓ $module module is loaded"
    else
        echo "✗ $module module not loaded"
    fi
done

# Kernel parameters
echo "Kernel command line:"
cat /proc/cmdline

# Check sysctl for security-related settings
echo "Key security sysctls:"
sysctl -a | grep -E 'randomize|protect|exec' | head -10 || true

# Suggest missing modules or tools
if ! command -v modinfo &> /dev/null; then
    echo "modinfo not available. Install kmod package."
fi

echo "Script completed. For module management, use modprobe."