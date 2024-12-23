# 12 Must-Have Shell Scripts for DevOps Engineers

As a DevOps Engineer, automation is your superpower. Shell scripts are versatile tools that can handle everything from monitoring system health to automating backups. Here's a collection of **12 daily-use shell scripts** to simplify your workflow and boost productivity.

Additionally, I am providing all the scripts, written and tested by me, to help you get started quickly.

---

## 1. Automatic Package Updater

**Filename:** `automatic_package_updater.sh`

This script automates the process of updating system packages to ensure your servers are always up-to-date with the latest security patches and features.

```bash
#!/bin/bash

# Check for root privileges
if [ "$EUID" -ne 0 ]; then
    echo "This script must be run as root"
    exit 1
fi 

# Update system packages and clean up unnecessary packages
echo "Starting system update and cleanup process..."

# Update system packages and clean up unnecessary packages
apt-get update && apt-get upgrade -y && apt-get autoremove -y && apt-get clean

echo "System Packages Updated and Cleaned Up"
```

---

## 2. File Backup

**Filename:** `backup.sh`

A simple yet powerful script to back up important files to a designated folder or remote server.

```bash
#!/bin/bash

SOURCE=/home/ubuntu/archies
DESTINATION=/home/ubuntu/backup
DATE=$(date +%Y-%m-%d_%H-%M-%S)
mkdir -p $DESTINATION/$DATE
cp -r $SOURCE $DESTINATION/$DATE
echo "Backup Completed on $DATE"
```

---

## 3. Connectivity Checker

**Filename:** `check-connectivity.sh`

This script tests internet connectivity by pinging a reliable server and notifies if the connection is down.

```bash
#!/bin/bash

read -p "Enter a Host name or Adress: " HOST
OUTPUT_FILE="/home/ubuntu/outputs/output.txt"

#Check if the host is reachable
if ping -c 1 $HOST &> /dev/null
then
	echo "$HOST is reachable" >> $OUTPUT_FILE
else
	echo "$HOST is not reachable" >> $OUTPUT_FILE
fi
```

---

## 4. Disk Usage Checker

**Filename:** `check-disk-usage.sh`

Monitors disk usage and issues a warning if usage exceeds a defined threshold.

```bash
#!/bin/bash

#Prompt user for threshold value
read -p "Enter the disk usage threshold percentage: " THRESHOLD
# Check disk usage and print a warning if usage is above the threshold
df -H | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5 " " $1 }' | while read output;
do
	usage=$(echo $output | awk '{print $1 }' | cut -d'%' -f1)
	partition=$(echo $output | awk '{ print $2 }')
	if [ $usage -ge $THRESHOLD ]; then
		echo "Warning: Disk Usage on $partition is at ${usage}%"
	fi
done
```

---

## 5. Database Backup

**Filename:** `db_backup.sh`

Automates database backups to protect critical data from loss.

```bash
#!/bin/bash
read -p "Enter the name of the database you want to backup: " DB_NAME
BACKUP_DIR="/home/ubuntu/db-backups"
DATE=$(date +$Y-%m-%d_%H-%M-%S)
mysqldump -u root -p $DB_NAME > $BACKUP_DIR/$DB_NAME-$DATE.sql
echo "Database Backup Completed: $BACKUP_DIR/$DB_NAME-$DATE.sql"
```

---

## 6. HTTP Response Time Checker

**Filename:** `http_response_check.sh`

Monitors the HTTP response time for critical endpoints to detect performance bottlenecks.

```bash
#!/bin/bash

# Default URLs (can be overridden by arguments)
URLS=("${@:-${DEFAULT_URLS[@]}}")

# Check HTTP response times for the provided URLs
for URL in "${URLS[@]}"; do
    if curl -o /dev/null -s --head --fail "$URL"; then
        RESPONSE_TIME=$(curl -o /dev/null -s -w '%{time_total}\n' "$URL")
        echo "Response Time for $URL: $RESPONSE_TIME seconds"
    else
        echo "Error: Unable to reach $URL"
    fi
done
```

---

## 7. Listening Ports Checker

**Filename:** `listen_port.sh`

Identifies which ports are currently being used, ensuring system security and resource management.

```bash
#!/bin/bash
#List all listening ports and the associated services 
netstat -tuln | grep LISTEN
```

---

## 8. Process and Memory Monitor

**Filename:** `monitor.sh`

Tracks system processes and their memory usage, helping diagnose performance issues.

```bash
#!/bin/bash
#Monitor system processes and their memory usage
ps aux --sort=-%mem | head -10
```

---

## 9. System Uptime Checker

**Filename:** `system_uptime_checks.sh`

Reports how long the system has been running, a useful metric for identifying system health.

```bash
#!/bin/bash
uptime
```

---

## 10. CPU and Memory Usage Alert

**Filename:** `resources_alert.sh`

Sends an alert if CPU or memory usage exceeds a defined threshold.

```bash
CPU_THRESHOLD=0
MEM_THRESHOLD=10

cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{ print $2 + $4 }')
mem_usage=$(free | awk '/Mem/ { print $3/$2 * 100.0 }')

if (( $(echo "$cpu_usage >= $CPU_THRESHOLD" | bc -l) )); then
    echo "High CPU usage detected: $cpu_usage%"
fi

if (( $(echo "$mem_usage >= $MEM_THRESHOLD" | bc -l) )); then
    echo "High memory usage detected: $mem_usage%"
fi 
```

---

## 11. Log Cleanup Script

**Filename:** `log_cleanup.sh`

Archives and removes older logs to free up disk space while retaining essential records.

```bash
#!/bin/bash
LOG_DIR="/var/log"
ARCHIVE_DIR="/var/log/archive"
DAYS_TO_KEEP=30

mkdir -p $ARCHIVE_DIR
find $LOG_DIR -type f -mtime +$DAYS_TO_KEEP -exec gzip {} \; -exec mv {}.gz $ARCHIVE_DIR \;
find $ARCHIVE_DIR -type f -mtime +90 -delete
echo "Log cleanup completed!"
```

---

## 12. Service Status and Start Checker

**Filename:** `service-status-check.sh`

This script checks whether a specified service is running and starts it if it's not active.

```bash
#!/bin/bash
read -p "Enter the service you want to check or start running: " SERVICE
# Check if the systemctl is running, if not start it
if systemctl is-active --quiet $SERVICE; then
	echo "$SERVICE is running"
else
	echo "$SERVICE is not running"
	systemctl start $SERVICE
	echo "$SERVICE has been started"
fi
```

---

### How to Use These Scripts

1. **Save the scripts** : Copy each script into a `.sh` file with the respective filenames.
2. **Make executable** : Run `chmod +x script_name.sh` to make them executable.
3. **Run** : Execute using `./script_name.sh`.
4. **Automate** : Schedule them with cron for daily or periodic execution.

---

### Why These Scripts Matter

* **Time-saving** : Automate repetitive tasks.
* **Proactive monitoring** : Detect issues before they escalate.
* **Data protection** : Regular backups minimize data loss risks.

---

### Conclusion

These scripts form a strong foundation for a DevOps Engineer's daily tasks. Tailor them to suit your infrastructure and workflows for maximum efficiency. Feel free to contribute your ideas or improvements to this repository!
