# Example Shell Script: System Information Gatherer

#!/bin/bash

set -euo pipefail

# Script to gather basic system information

echo "=== System Information ==="
echo "Hostname: $(hostname)"
echo "OS: $(cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2 | tr -d '"')"
echo "Uptime: $(uptime -p)"
echo "Memory Usage:"
free -h
echo "Disk Usage:"
df -h /

echo "
Logged in users:"
who