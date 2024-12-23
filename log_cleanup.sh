#!/bin/bash
LOG_DIR="/var/log"
ARCHIVE_DIR="/var/log/archive"
DAYS_TO_KEEP=30

mkdir -p $ARCHIVE_DIR
find $LOG_DIR -type f -mtime +$DAYS_TO_KEEP -exec gzip {} \; -exec mv {}.gz $ARCHIVE_DIR \;
find $ARCHIVE_DIR -type f -mtime +90 -delete
echo "Log cleanup completed!"