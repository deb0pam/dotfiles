while true
do
   battery="$(cat /sys/class/power_supply/BAT1/capacity)%"
   b=$(cat /sys/class/power_supply/BAT1/status)
   ip=$(ping -c 1 google.com > /dev/null 2>&1 && echo "Connected" || echo "Disconnected")
   vol="$(pactl get-sink-volume 0 | awk -F '/' '{print $2}' | grep -o '[0-9]\+')%"
   brightness=$(xrandr --verbose | grep -i brightness | awk '{print $2 * 100 "%"}')
   t=$(echo "Storage: $(df -h / | awk '/\// {print $3 "/" $2 " GB"}') RAM: $(free -h | awk '/Mem:/ {print $3 "/" $2}') CPU: $(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4"%"}')")
   xsetroot -name "$t vol:$vol bt:$battery $b bri:$brightness $ip $(date +"%A %d.%m.%y %H:%M:%S")"
   sleep 0.5
done
