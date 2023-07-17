#!/bin/bash

DEFAULT_PROCESS="./default_process.sh"

# Function to start the process
start_process() {
    echo "Starting the process: $1"
    "$@" &
    PID=$!
}

# Function to monitor and restart the process
monitor_process() {
    while true; do
        if ! ps -p $PID > /dev/null; then
            echo "The process has crashed. Restarting..."
            start_process "$@"
        fi
        sleep 1
    done
}

if [ $# -eq 0 ]; then
    echo "No process specified. Starting the default process: $DEFAULT_PROCESS"
    start_process "$DEFAULT_PROCESS"
else
    start_process "$@"
fi

monitor_process "$@"
