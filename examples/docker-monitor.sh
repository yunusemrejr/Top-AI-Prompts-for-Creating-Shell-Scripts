#!/bin/bash

set -euo pipefail

# OS-specific: Docker monitoring for Linux (systemd-based)

if ! command -v docker &> /dev/null; then
    echo "Docker not installed."
    exit 1
fi

echo "Docker containers status:"
docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}"

echo "
Resource usage:"
docker stats --no-stream --format "table {{.Container}}\t{{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}"

# Check systemd service
if systemctl is-active --quiet docker; then
    echo "✓ Docker service is active"
else
    echo "✗ Docker service not active"
fi

# Logs for last errors
journalctl -u docker --since "1 hour ago" | tail -20 || true

echo "Use 'docker system prune' for cleanup."