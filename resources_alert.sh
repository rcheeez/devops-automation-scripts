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