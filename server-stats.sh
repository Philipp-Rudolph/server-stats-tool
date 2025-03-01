echo "#################"
echo "# Server Stats #"
echo "#################"

# Display the current date and time
echo "Current date and time: $(date)"

# Display os version, uptime, load average and hostname
echo "############################################"
echo "# OS version, uptime, load average and host #"
echo "############################################"

# Display the OS version
echo "OS version: $(cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2 | sed 's/"//g')"
# Display the uptime
echo "Uptime: $(uptime -p)"
# Display the load average
echo "Load average: $(uptime | awk -F'average:' '{print $2}')"
# Display the hostname
echo "Hostname: $(hostname)"

# Display the total CPU usage in percentage
echo "##################################"
echo "# Total CPU usage in percentage: #"
echo "##################################"

# Display the total CPU usage in percentage
echo "Total CPU usage in percentage: $(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')%"

# Display the total memory usage in percentage
echo "#####################################"
echo "# Total memory usage in percentage: #"
echo "#####################################"

# Display the total memory usage in percentage
echo "Total memory usage in percentage: $(free | grep Mem | awk '{print $3/$2 * 100.0}')%"

# Display the total disk usage in percentage
echo "###################################"
echo "# Total disk usage in percentage: #"
echo "###################################"

# Display the total disk usage in percentage
echo "Total disk usage in percentage: $(df -h | awk '$NF=="/"{printf "%s", $5}')"

# Display top 5 processes consuming CPU
echo "##################################"
echo "# Top 5 processes consuming CPU: #"
echo "##################################"

# Display top 5 processes consuming CPU
echo "$(ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -6)"

# Display top 5 processes consuming memory
echo "#####################################"
echo "# Top 5 processes consuming memory: #"
echo "#####################################"


# Display top 5 processes consuming memory
echo "$(ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -6)"

