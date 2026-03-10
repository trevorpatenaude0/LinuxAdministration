#!/bin/bash
# Network Information Dump Script
# Usage: sudo ./network_info.sh

mkdir -p ~/network_logs

DATE=$(date +%Y-%m-%d)
FILE=~/network_logs/network_info_${DATE}.txt

{
    echo "======================================"
    echo "        NETWORK INFORMATION DUMP"
    echo "======================================"
    echo ""
    echo "=== System Information ==="
    uname -a
    hostname
    echo ""

    echo "=== IP Addresses ==="
    ip addr show
    echo ""

    echo "=== Routing Table ==="
    ip route show
    echo ""

    echo "=== Network Links ==="
    ip link show
    echo ""

    echo "=== ARP / Neighbor Table ==="
    ip neigh show
    echo ""

    echo "=== Listening Ports ==="
    ss -tuln
    echo ""

    echo "=== Interface Details ==="
    IFACE=$(ip -o link show | awk -F': ' '$2 ~ /^(en|eth)/ {print $2; exit}')
    if [ -n "$IFACE" ]; then
        echo "Interface: $IFACE"
        ethtool "$IFACE" 2>/dev/null || echo "ethtool: no output"
    else
        echo "No Ethernet interface found"
    fi
    echo ""

    echo "=== DNS Configuration ==="
    cat /etc/resolv.conf 2>/dev/null || echo "DNS config not found"
    echo ""

    echo "=== External Connectivity Test ==="
    traceroute -n google.com 2>/dev/null || echo "traceroute not found"
    echo ""

    echo "=== End of Report ==="
    echo "Generated on: $(date)"
    echo "======================================"
} | tee "$FILE"

echo "Network dump completed"
echo "File saved to: $FILE"
ls -l "$FILE"