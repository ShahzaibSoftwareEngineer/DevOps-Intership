#!/bin/bash
# ---------------------------------------------------------
# System Monitoring Script with Logging
# Author: <Your Name>
# Date: $(date +%Y-%m-%d)
# ---------------------------------------------------------
# Description:
#   Monitors CPU, memory, disk, and network usage.
#   Logs results and warns if thresholds are exceeded.
# ---------------------------------------------------------

# Exit on any error
set -euo pipefail

# Variables
LOG_DIR="/home/shahzaib/Desktop/system-monitor"
LOG_FILE="$LOG_DIR/system_monitor.log"
DATE=$(date '+%Y-%m-%d %H:%M:%S')

# Thresholds (you can adjust)
CPU_LIMIT=80
MEM_LIMIT=80
DISK_LIMIT=80

# Create log directory if not exists
mkdir -p "$LOG_DIR"

echo "--------------------------------------------" >> "$LOG_FILE"
echo "[$DATE] System Monitoring Started" >> "$LOG_FILE"

# ---- CPU USAGE ----
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
echo "CPU Usage: ${CPU_USAGE}% " >> "$LOG_FILE"

if (( ${CPU_USAGE%.*} > CPU_LIMIT )); then
    echo "⚠️  WARNING: CPU usage is above ${CPU_LIMIT}% (${CPU_USAGE}%)" >> "$LOG_FILE"
fi

# ---- MEMORY USAGE ----
MEM_USAGE=$(free | awk '/Mem/{printf("%.2f"), $3/$2*100}')
echo "Memory Usage: ${MEM_USAGE}% " >> "$LOG_FILE"

if (( ${MEM_USAGE%.*} > MEM_LIMIT )); then
    echo "⚠️  WARNING: Memory usage is above ${MEM_LIMIT}% (${MEM_USAGE}%)" >> "$LOG_FILE"
fi

# ---- DISK USAGE ----
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
echo "Disk Usage: ${DISK_USAGE}% " >> "$LOG_FILE"

if (( DISK_USAGE > DISK_LIMIT )); then
    echo "⚠️  WARNING: Disk usage is above ${DISK_LIMIT}% (${DISK_USAGE}%)" >> "$LOG_FILE"
fi

# ---- NETWORK CHECK ----
PING_RESULT=$(ping -c 2 8.8.8.8 &> /dev/null && echo "Online" || echo "Offline")
echo "Network Status: $PING_RESULT" >> "$LOG_FILE"

# ---- LOG END ----
echo "[$DATE] Monitoring Completed" >> "$LOG_FILE"
echo "--------------------------------------------" >> "$LOG_FILE"

