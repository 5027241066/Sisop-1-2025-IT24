echo "$(lscpu | grep -m1 'Model name')"
echo "CPU Usage: $(top -bn1 | awk '/Cpu\(s\)/ {print 100 - $8}')%"
echo "Terminal: $(tty)"
