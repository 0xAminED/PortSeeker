#!/bin/bash

# Advanced Bash Port Scanner
# This script scans specific ports or a range of ports on a target host.

# Default values
TARGET=""
PORTS=""
TIMEOUT=1
THREADS=50

# Function to display the usage of the script
usage() {
    echo "Usage: $0 -t <target_host> -p <ports> -T <timeout_seconds> -p <threads>"
    echo
    echo "  -t    Target host (IP address or domain)"
    echo "  -p    Ports (single port or port range like 80 or 80-3000)"
    echo "  -T    Timeout in seconds (default: 1)"
    echo "  -p    Number of threads (default: 50)"
    exit 1
}

# Function to scan a single port using netcat
scan_port() {
    local target=$1
    local port=$2
    local timeout=$3
    (echo > /dev/tcp/$target/$port) &>/dev/null && echo "Port $port is OPEN" || echo "Port $port is CLOSED"
}

# Function to scan ports in parallel
scan_ports_parallel() {
    local target=$1
    local ports=$2
    local timeout=$3
    local threads=$4

    # Loop over ports and run scans in parallel using xargs
    echo "$ports" | xargs -n 1 -P $threads -I {} bash -c "scan_port $target {} $timeout"
}

# Parse command line arguments
while getopts "t:p:T:" opt; do
    case "$opt" in
        t) TARGET=$OPTARG ;;
        p) PORTS=$OPTARG ;;
        T) TIMEOUT=$OPTARG ;;
        p) THREADS=$OPTARG ;;
        *) usage ;;
    esac
done

# Validate if target is set
if [ -z "$TARGET" ] || [ -z "$PORTS" ]; then
    echo "Target host and ports are required."
    usage
fi

# Validate that the target is a valid IP or hostname
if ! ping -c 1 "$TARGET" &>/dev/null; then
    echo "Invalid target: $TARGET. Unable to reach the host."
    exit 1
fi

# If the port is a range (e.g., 80-3000), expand it
if [[ "$PORTS" =~ ^([0-9]+)-([0-9]+)$ ]]; then
    START_PORT=${BASH_REMATCH[1]}
    END_PORT=${BASH_REMATCH[2]}
    PORTS=$(seq $START_PORT $END_PORT)
fi

# Print the parameters
echo "Scanning target: $TARGET"
echo "Scanning ports: $PORTS"
echo "Timeout: $TIMEOUT seconds"
echo "Threads: $THREADS"

# Perform the port scan
scan_ports_parallel $TARGET "$PORTS" $TIMEOUT $THREADS
