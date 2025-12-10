#!/bin/bash

TARGET=$1

if [ -z "$TARGET" ]; then
    echo "Usage: ./adv_scan.sh <domain or IP>"
    exit 1
fi

DATE=$(date +"%Y-%m-%d_%H-%M")
OUTPUT_DIR="day4_advanced/output_$DATE"
mkdir -p $OUTPUT_DIR

echo "====================="
echo " Advanced Recon Scan"
echo " Target: $TARGET"
echo "====================="
echo ""

echo "[1] Subdomain Enumeration"
echo "-------------------------"
subfinder -silent -d $TARGET > $OUTPUT_DIR/subdomains.txt 2>/dev/null
if [ ! -s "$OUTPUT_DIR/subdomains.txt" ]; then
    echo "No subdomains found."
else
    cat $OUTPUT_DIR/subdomains.txt
fi
echo ""

echo "[2] Port Scan + Service Detection (Nmap)"
echo "----------------------------------------"
nmap -A -T4 -sV -O -p- --reason $TARGET -oN $OUTPUT_DIR/nmap_scan.txt
echo "Nmap scan complete."
echo ""

echo "[3] Extracting Services for CVE Check"
echo "-------------------------------------"
grep -oP '\d+/tcp\s+open\s+\S+' $OUTPUT_DIR/nmap_scan.txt > $OUTPUT_DIR/open_ports.txt

echo "[4] CVE Mapping"
echo "----------------"
while read line; do
    PORT=$(echo $line | awk '{print $1}')
    SERVICE=$(echo $line | awk '{print $3}')
    echo "Checking CVEs for $SERVICE"
    curl -s "https://cve.circl.lu/api/search/$SERVICE" | jq '.[] | {id, summary}' > $OUTPUT_DIR/cve_$SERVICE.json
done < $OUTPUT_DIR/open_ports.txt

echo "CVE reports saved."
echo ""

echo "[5] Generating Summary Report"
echo "------------------------------"

cat <<EOF > $OUTPUT_DIR/summary.txt
==============================
 Advanced Recon Summary
 Target: $TARGET
 Date: $DATE
==============================

Subdomains found:
$(cat $OUTPUT_DIR/subdomains.txt 2>/dev/null)

Open ports:
$(cat $OUTPUT_DIR/open_ports.txt 2>/dev/null)

CVE Reports:
Saved under $OUTPUT_DIR/*.json

EOF

echo "Report generated at: $OUTPUT_DIR/summary.txt"
