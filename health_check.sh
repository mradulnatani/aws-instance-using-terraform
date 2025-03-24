#!/bin/bash

SERVERS=("10.0.1.11" "10.0.1.12" "10.0.1.13" "10.0.1.14" "10.0.1.15")
USER="ubuntu"  # Change based on your AMI (e.g., "ec2-user" for Amazon Linux)
LOG_FILE="/var/log/server_health.log"

echo "===== Health Check - $(date) =====" >> $LOG_FILE

for SERVER in "${SERVERS[@]}"; do
    echo "Checking server: $SERVER" >> $LOG_FILE

    ssh -i /path/to/key.pem -o ConnectTimeout=5 $USER@$SERVER << EOF >> $LOG_FILE 2>&1
        echo "==== CPU Usage ===="
        top -bn1 | grep "Cpu(s)"
        
        echo "==== Memory Usage ===="
        free -h
        
        echo "==== Disk Usage ===="
        df -h /
        
        echo "==== Network Latency ===="
        ping -c 3 8.8.8.8
        
        echo "==== Running Services ===="
        systemctl --type=service --state=running | grep "nginx\|apache\|mysql"
EOF

    echo "Health check completed for $SERVER"
done

echo "=====================================" >> $LOG_FILE
