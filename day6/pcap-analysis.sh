#!/bin/bash

# Auto-detect latest pcap file
PCAP_FILE=$(ls -t *.pcap 2>/dev/null | head -n 1)

if [ -z "$PCAP_FILE" ]; then
    echo "❌ No .pcap files found in the current directory!"
    exit 1
fi

echo "[*] Using latest PCAP file: $PCAP_FILE"
echo ""

# -----------------------------
#   ANALYSIS SECTIONS
# -----------------------------

echo "[*] Top 10 IP addresses:"
tshark -r "$PCAP_FILE" -T fields -e ip.src -e ip.dst 2>/dev/null \
    | awk '{print $1"\n"$2}' | sort | uniq -c | sort -nr | head -n 10
echo ""

echo "[*] HTTP Requests:"
tshark -r "$PCAP_FILE" -Y http.request -T fields -e http.host -e http.request.uri 2>/dev/null \
    | head -n 20
echo ""

echo "[*] Suspicious non-HTTP traffic (>1024 ports):"
tshark -r "$PCAP_FILE" -T fields -e ip.dst -e tcp.dstport -Y "tcp.dstport > 1024" 2>/dev/null \
    | sort | uniq -c | sort -nr | head -n 20
echo ""