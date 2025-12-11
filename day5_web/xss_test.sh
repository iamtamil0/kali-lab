#!/bin/bash

TARGET=$1
PAYLOAD='<script>alert(1)</script>'

if [ -z "$TARGET" ]; then
    echo "Usage: ./xss_test.sh <url>"
    exit 1
fi

DATE=$(date +"%F_%H-%M")
OUT="day5_web/xss_$DATE.txt"

echo "[1] Testing XSS injection..."

RESPONSE=$(curl -sG "$TARGET" --data-urlencode "q=$PAYLOAD")

if echo "$RESPONSE" | grep -q "$PAYLOAD"; then
    echo "XSS Vulnerable!" > $OUT
else
    echo "Not Vulnerable." > $OUT
fi

echo "XSS test saved: $OUT"
