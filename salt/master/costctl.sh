#!/bin/bash

TARGET_IP="10.0.10.27"
SHUTDOWN_SCRIPT="/usr/local/sbin/costctl_down.sh"
IDLE_LIMIT=600 # 10 minutes
CHECK_INTERVAL=5

# Initial State
STATE="WAITING"
idle_time=0

echo "Monitor started. Current State: $STATE"

while true; do
    # Check for active connection
    connection_active=$(ss -ntu | grep -E "ESTAB.*:22.*$TARGET")

    case $STATE in
        "WAITING")
            if [ -n "$connection_active" ]; then
                STATE="CONNECTED"
                echo "$(date) IP $TARGET_IP detected. Transitioning to state: $STATE"
            fi
            ;;

        "CONNECTED")
            if [ -z "$connection_active" ]; then
                STATE="PENDING"
                idle_time=0
                echo "$(date) Connection lost. Transitioning to state: $STATE (Timer started)"
            fi
            ;;

        "PENDING")
            if [ -n "$connection_active" ]; then
                STATE="CONNECTED"
                idle_time=0
                echo "$(date) Connection re-established. Transitioning back to state: $STATE"
            else
                idle_time=$((idle_time + CHECK_INTERVAL))
                
                # Check if 10 minutes (600s) have passed
                if [ "$idle_time" -ge "$IDLE_LIMIT" ]; then
                    echo "$(date) 10 minute grace period expired. Executing shutdown."
                    bash "$SHUTDOWN_SCRIPT"
                    exit 0 # Systemd will restart the script, putting us back in WAITING
                fi
            fi
            ;;
    esac

    sleep "$CHECK_INTERVAL"
done
