#!/bin/bash

echo "===== System Information ====="
echo "Date: $(date)"
echo "User: $(whoami)"
echo "Uptime:"
uptime
echo "Disk Usage:"
df -h
echo "Memory Usage:"
free -h