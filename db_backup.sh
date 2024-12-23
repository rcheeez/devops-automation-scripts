#!/bin/bash
read -p "Enter the name of the database you want to backup: " DB_NAME
BACKUP_DIR="/home/ubuntu/db-backups"
DATE=$(date +$Y-%m-%d_%H-%M-%S)
mysqldump -u root -p $DB_NAME > $BACKUP_DIR/$DB_NAME-$DATE.sql
echo "Database Backup Completed: $BACKUP_DIR/$DB_NAME-$DATE.sql"