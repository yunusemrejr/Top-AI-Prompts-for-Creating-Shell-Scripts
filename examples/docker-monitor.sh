#!/usr/bin/env bash

set -euo pipefail

# Enhanced Docker + systemd monitoring for Linux
log() { echo -e "\033[0;32m[INFO]\033[0m $*"; }

if ! command -v docker &>/dev/null; then
  echo "Docker not found. Install with: curl -fsSL https://get.docker.com | sh"
  exit 1
fi

log "Docker containers:"
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}" || true

log "Resource stats (top 5):"
docker stats --no-stream --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}" | head -6 || true

if command -v systemctl &>/dev/null; then
  if systemctl is-active --quiet docker; then
    log "Docker service: active"
  else
    warn "Docker service not active"
  fi
fi

journalctl -u docker --since "30 min ago" --no-pager | tail -10 || true