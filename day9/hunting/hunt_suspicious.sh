#!/bin/bash
LOG="day8/siem/auth.log"

echo "[*] Failed login count:"
grep "Failed password" $LOG | wc -l

echo "[*] Rare IPS:"
grep "Failed password" $LOG | awk '{print $NF} | sort | uniq -c | sort -nr