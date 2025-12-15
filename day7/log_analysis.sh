#!/bin/bash

echo "===== SYSTEM LOG ANALYSIS ====="
echo "Date: $(date)"
echo ""

#Auto-dectect log file
if [ -f /var/log/auth.log ]; then
    LOG_FILE="/var/log/auth.log"
elif [ -f /var/log/secure ]; then
    LOG_FILE="/var/log/secure"
else
    LOG="/var/log/syslog"
fi


