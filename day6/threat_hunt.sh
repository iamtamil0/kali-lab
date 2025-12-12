#!/bin/bash

echo "[*] Detecting best auth log for this system..."

# Auto-detect logs
if [ -f /var/log/auth.log ]; then
    AUTH_LOG="/var/log/auth.log"
elif [ -f /var/log/secure ]; then
    AUTH_LOG="/var/log/secure"
else
    AUTH_LOG="/var/log/syslog"
fi

echo "[*] Using log file: $AUTH_LOG"
echo ""

echo "[*] Failed Login Attempts:"
grep -i "failed" "$AUTH_LOG" | tail -n 20
echo ""

echo "[*] Successful Login Attempts:"
grep -i "accepted" "$AUTH_LOG" | tail -n 20
echo ""

echo "[*] Sudo Usage:"
grep -i "sudo" "$AUTH_LOG" | tail -n 20
echo ""

echo "[*] Authentication Failures:"
grep -i "authentication failure" "$AUTH_LOG" | tail -n 20
echo ""