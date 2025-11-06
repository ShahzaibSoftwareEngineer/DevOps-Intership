#!/bin/bash

LOG_DIR="/home/shahzaib/Desktop/system-monitor"
LOG_FILE="$LOG_DIR/system_monitor.log"
DATE=$(date '+%Y-%m-%d %H:%M:%S')

mkdir -p "$LOG_DIR"

CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
MEM=$(free | awk '/Mem/{printf("%.2f"), $3/$2*100}')
DISK=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
NET=$(ping -c 2 8.8.8.8 &> /dev/null && echo "Online" || echo "Offline")

echo "[$DATE] CPU: ${CPU}% | MEM: ${MEM}% | DISK: ${DISK}% | NET: ${NET}" >> "$LOG_FILE"

