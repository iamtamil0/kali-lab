#!/bin/bash

TARGET="127.0.0.1"

echo "===== Basic Vulnerability Scan ====="
echo "Target: $TARGET"
echo "Date: $(date)"
echo ""

echo "---- Detecting Open Ports ----"
OPEN_PORTS=$(ss -tuln | awk 'NR>1 {print $5}' | awk -F':' '{print $NF}' | sort -u)

if [ -z "$OPEN_PORTS" ]; then
    echo "No open ports found."
else
    echo "$OPEN_PORTS"
fi

echo ""
echo "---- Service Version Info ----"

for port in $OPEN_PORTS; do
    echo "Checking port $port..."
    timeout 2 bash -c "echo '' > /dev/tcp/$TARGET/$port" 2>/dev/null && \
    echo "Port $port is open" || echo "Port $port closed or filtered"

    # Very simple banner grab
    BANNER=$(timeout 2 bash -c "echo -e '\n' | nc -nv $TARGET $port 2>/dev/null")
    if [ ! -z "$BANNER" ]; then
        echo "Banner: $BANNER"
    fi
    echo ""
done

echo "===== Scan Complete ====="