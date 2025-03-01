#!/bin/bash

# Colors for formatting
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
RESET='\033[0m'

# Function to print section headers
print_header() {
    echo -e "${WHITE}###############################################${RESET}"
    echo -e "${CYAN}# $1 ${RESET}"
    echo -e "${WHITE}###############################################${RESET}"
}

# Print script title
echo -e "${WHITE}###########################${RESET}"
echo -e "${GREEN}#     Server Stats       #${RESET}"
echo -e "${WHITE}###########################${RESET}\n"

# Display the current date and time
echo -e "${YELLOW}Current Date and Time:${RESET} $(date)\n"

# OS Information, Uptime, Load Average, and Hostname
print_header "OS Version, Uptime, Load Average, and Host"

echo -e "${BLUE}OS Version:${RESET} $(grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '"')"
echo -e "${BLUE}Uptime:${RESET} $(uptime -p)"
echo -e "${BLUE}Load Average:${RESET} $(uptime | awk -F'average:' '{print $2}')"
echo -e "${BLUE}Hostname:${RESET} $(hostname)\n"

# CPU Usage
print_header "Total CPU Usage (%)"
cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
echo -e "${RED}CPU Usage:${RESET} ${cpu_usage}%\n"

# Memory Usage
print_header "Total Memory Usage (%)"
mem_usage=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
echo -e "${RED}Memory Usage:${RESET} ${mem_usage}%\n"

# Disk Usage
print_header "Total Disk Usage (%)"
disk_usage=$(df -h | awk '$NF=="/"{print $5}')
echo -e "${RED}Disk Usage:${RESET} ${disk_usage}\n"

# Top 5 CPU-consuming processes
print_header "Top 5 Processes by CPU Usage"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -6 | awk '{printf "%-8s %-8s %-40s %-6s %-6s\n", $1, $2, $3, $4, $5}'
echo ""

# Top 5 Memory-consuming processes
print_header "Top 5 Processes by Memory Usage"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -6 | awk '{printf "%-8s %-8s %-40s %-6s %-6s\n", $1, $2, $3, $4, $5}'
echo ""
