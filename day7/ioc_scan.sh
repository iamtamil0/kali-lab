#!/bin/bash

echo "===== IOC SCAN ====="
echo ""

echo "[1] Suspicious processes:"
ps aux | grep -E "nc/netcat/bash -i|python -c|perl -e" | grep -v grep
echo ""

echo "[2] Suspicious listening ports:"
ss -tulnp | grep -E "4444|5555|1337|9001"
echo ""

echo "[3] Suspicious cron jobs:"
ls -la /etc/cron* 2>/dev/null
echo ""

echo "[4] World-writable files (possible backdoors):"
find / -xdev -type f -prem -0002 2>/dev/null | head -20
echo ""