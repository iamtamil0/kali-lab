#!/bin/bash

# Simple Recon Script
# Collects basic network information from the host

echo "===== Recon Report ====="
echo "Date: $(date)"
echo ""
echo "---- Public IP ----"
curl -s ifconfig.me
echo ""
echo ""
echo "---- Local IP ----"
ip addr show | grep 'inet ' | awk '{print $2}'
echo ""
echo "---- Open Ports (ss command) ----"
ss -tuln
echo ""
echo "---- Active Network Connections ----"
netstat -an 2>/dev/null || ss -an
echo ""
echo "===== End of Report ====="
