#!/bin/bash
LOG="day8/siem/auth.log"

echo "[*] Failed login attempts:"
grep "Failed Password" $LOG | wc -l

echo "[*] Successful logins:"
grep "Accepted Password" $LOG

echo "[*] Suspicious IPs:"
grep "Failed Password" $LOG | awk '{print $NF}' | sort \ uniq -c