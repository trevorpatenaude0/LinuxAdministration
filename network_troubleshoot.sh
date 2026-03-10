#!/bin/bash
# Interactive Network Troubleshooter
# Usage: ./network_troubleshoot.sh

echo "Welcome to Network Troubleshooter."
echo "Enter server type: 1 for CentOS Stream 9, 2 for Ubuntu 24.04 LTS"
read -p "Choice: " choice

case $choice in
    1)
        echo ""
        echo "CentOS Stream 9 Suggestions:"
        echo "No Internet: Check 'nmcli device status'"
        echo "Restart networking: sudo systemctl restart NetworkManager"
        echo "Set Static IP: nmcli con mod 'System enp1s0' ipv4.addresses 192.168.1.10/24 ipv4.gateway 192.168.1.1 ipv4.method manual"
        echo "                  nmcli con up 'System enp1s0'"
        echo "DNS Check: cat /etc/resolv.conf && dig google.com"
        echo "Trace Path: traceroute google.com"
        ;;
    2)
        echo ""
        echo "Ubuntu 24.04 LTS Suggestions:"
        echo "No Internet: Check 'ip addr'"
        echo "Restart networking: sudo netplan apply"
        echo "Set Static IP: Edit /etc/netplan/50-cloud-init.yaml"
        echo "               addresses: [192.168.1.10/24]"
        echo "               gateway4: 192.168.1.1"
        echo "               dhcp4: false"
        echo "               Then run: sudo netplan apply"
        echo "DNS Check: cat /etc/resolv.conf && dig google.com"
        echo "Trace Path: traceroute google.com"
        ;;
    *)
        echo "Invalid choice. Exiting."
        ;;
esac