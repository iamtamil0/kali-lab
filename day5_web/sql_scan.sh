#!/bin/bash

TARGET=$1

if [ -z "$TARGET" ]; then
    echo "Usage: ./sql_scan.sh <url>"
    exit 1
fi

DATE=$(date +"%F_%H-%M")
OUT="day5_web/sql_output_$DATE"
mkdir -p $OUT

echo "[1] Running SQLMap..."
sqlmap -u "$TARGET" --batch --crawl=1 --answers="follow-redirects=Y" --output-dir=$OUT

echo "SQL Injection scan completed."
