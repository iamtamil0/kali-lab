#!/bin/bash

TARGET=$1

if [ -z "$TARGET" ]; then
    echo "Usage: ./owasp_recon.sh <url>"
    exit 1
fi

DATE=$(date +"%Y-%m-%d_%H-%M")
OUT="day5_web/output_$DATE"
mkdir -p $OUT

echo "[1] Checking robots.txt"
curl -s $TARGET/robots.txt > $OUT/robots.txt
echo "Done."

echo "[2] Directory Brute-Force (Gobuster)"
gobuster dir -u $TARGET -w /usr/share/wordlists/dirb/common.txt -o $OUT/dirs.txt

echo "[3] Extract Forms for further attack"
curl -s $TARGET | grep -i "<form" > $OUT/forms.txt

echo "Recon complete! Output saved in $OUT"
