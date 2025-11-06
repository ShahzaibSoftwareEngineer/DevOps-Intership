#!/bin/bash
SRC="/home/shahzaib/Desktop/DEVOPS"
DEST="/home/shahzaib/Desktop/Devops-Intership"
LOG_FILE="$DEST/backup.log"
TIMESTAMP=$(date +'%Y-%m-%d_%H-%M-%S')
BACKUP_FILE="$DEST/backup_$TIMESTAMP.tar.gz"
mkdir -p "$DEST"
echo "[$(date '+%F %T')] Starting backup..." >> "$LOG_FILE"
tar -czf "$BACKUP_FILE" "$SRC" >> "$LOG_FILE" 2>&1
if [[ -f "$BACKUP_FILE" ]]; then
    echo "[$(date '+%F %T')] Backup SUCCESS: $BACKUP_FILE" >> "$LOG_FILE"
else
    echo "[$(date '+%F %T')] Backup FAILED" >> "$LOG_FILE"
    exit 1
fi
echo "[$(date '+%F %T')] Backup completed successfully." >> "$LOG_FILE"

