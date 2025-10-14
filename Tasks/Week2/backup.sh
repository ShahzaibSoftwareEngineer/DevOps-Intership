#!/bin/bash
# ---------------------------------------------------------
# Automated Backup Script with Logging
# Author: <Your Name>
# Date: $(date +%Y-%m-%d)
# ---------------------------------------------------------
# Usage: sudo ./backup.sh /path/to/source /path/to/backup_dir
# Example: sudo ./backup.sh /home/ubuntu/project /var/backups/project_backups
# ---------------------------------------------------------

# Exit on error and unset variable usage
set -euo pipefail

# Arguments
SRC="${1:-/home/shahzaib/Desktop/DEVOPS}"      # Source directory (default if none)
DEST_BASE="${2:-/home/shahzaib/Desktop/Devops-Intership}" # Backup destination directory
TIMESTAMP=$(date +'%Y-%m-%d_%H-%M-%S')
DEST_DIR="$DEST_BASE/$TIMESTAMP"
LOG_FILE="$DEST_BASE/backup.log"
KEEP_DAYS=7  # number of days to keep backups

# Ensure destination folder exists
mkdir -p "$DEST_DIR"

# Start logging
echo "--------------------------------------------" >> "$LOG_FILE"
echo "[$(date '+%F %T')] Starting backup" >> "$LOG_FILE"
echo "Source: $SRC" >> "$LOG_FILE"
echo "Destination: $DEST_DIR" >> "$LOG_FILE"

# Create compressed archive
tar -czpf "$DEST_DIR/backup_$TIMESTAMP.tar.gz" -C "$(dirname "$SRC")" "$(basename "$SRC")" >> "$LOG_FILE" 2>&1

# Verify and log status
if [[ -f "$DEST_DIR/backup_$TIMESTAMP.tar.gz" ]]; then
  echo "[$(date '+%F %T')] Backup SUCCESS ✅" >> "$LOG_FILE"
else
  echo "[$(date '+%F %T')] Backup FAILED ❌" >> "$LOG_FILE"
  exit 1
fi

# Rotate old backups
echo "[$(date '+%F %T')] Cleaning backups older than $KEEP_DAYS days..." >> "$LOG_FILE"
find "$DEST_BASE" -type f -name "*.tar.gz" -mtime +"$KEEP_DAYS" -exec rm -f {} \; >> "$LOG_FILE" 2>&1
echo "[$(date '+%F %T')] Rotation complete" >> "$LOG_FILE"

echo "[$(date '+%F %T')] Backup finished successfully." >> "$LOG_FILE"
echo "--------------------------------------------" >> "$LOG_FILE"

