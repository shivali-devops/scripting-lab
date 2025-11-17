#!/usr/bin/env bash
# ==========================================
# Script: cleanup_docker.sh
# Description: Safely removes unused Docker containers, images, volumes, and networks.
# Usage: ./cleanup_docker.sh
# Author: Shivali Kakade
# ==========================================

set -e

echo "=== Docker Cleanup Utility ==="

read -p "This will remove all unused Docker resources. Do you want to continue? (y/n): " confirm 
[[ "$confirm" =~ ^([yY][eE][sS]|[yY])$ ]] || { echo "Cleanup aborted."; exit 0; }

echo "[1/4] Removing stopped containers..."
docker container prune -f

echo "[2/4] Removing unused images..."
docker image prune -a -f

echo "[3/4] Removing unused volumes..."
docker volume prune -f

echo "[4/4] Removing unused networks..."
docker network prune -f

echo "✔ Cleanup complete."