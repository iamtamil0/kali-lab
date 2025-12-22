#!/bin/bash
LOG="day10/red/logs/auth.log"

FAILS=$(grep "Failed password" $LOG | wc -l)
SUCCESS=$(grep "Accepted password" $LOG)

if [ "$FAILS" -gt 2 ]; then
  echo "[ALERT] Multiple failed logins detected"
fi

if [ ! -z "$SUCCESS" ]; then
  echo "[ALERT] Successful login after failures"
fi
