#!/bin/bash

OUT="capture_$(date +%F_%H-%M).pcap"

# Capture 200 packets on interface eth0
sudo tcpdump -i eth0 -c 200 -w $OUT

echo "Packet capture saved to $OUT"