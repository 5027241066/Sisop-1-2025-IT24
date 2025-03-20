fragment_usage=$(awk '/MemTotal/ {total=$2} /MemAvailable/ {avail=$2} END {print (total-avail)*100/total "%"}' /proc/meminfo)
fragment_used=$(awk '/MemTotal/ {total=$2} /MemAvailable/ {avail=$2} END {print (total-avail)/1024 " MB"}' /proc/meminfo)
fragment_tot=$(awk '/MemTotal/ {print $2/1024 " MB"}' /proc/meminfo)
fragment_avail=$(awk '/MemAvailable/ {print $2/1024 " MB"}' /proc/meminfo)

echo "Fragments Usage: $fragment_usage ($fragment_used / $fragment_tot)"
echo "Fragments Available: $fragment_avail"

