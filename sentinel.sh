#!/bin/bash
# 
# # Needed for notify-send to work in Cron
export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"

ram_threshold=80
cpu_threshold=80
disk_threshold=80
LOG_PATH="/home/dilip/Projects/Bash Scripting/System Resource Sentinel/system_log.txt"

alert()
{
    if [[ $1 == "ram" ]]; then
        notify-send "Alert" "you have used more than 80% of your RAM"
    elif [[ $1 == "cpu" ]]; then
        notify-send "Alert" "you have used more than 80% of your CPU"
    else
        notify-send "Alert" "you have used more than 80% of your DISK storage"
    fi
    
}

logging()
{
    local timestamp=$(date +"%d/%m/%y %H:%M:%S")
    if [[ -f "$LOG_PATH" ]]; then
        echo "$1  $2  $3  ${timestamp}" >> "$LOG_PATH"
    else
        printf "RAM  CPU  DISK  DATE \n" >> "$LOG_PATH"
        echo "$1  $2  $3   ${timestamp}" >> "$LOG_PATH"
    fi
}

check_resources()
{
    is_alert_needed=false
    #RAM
    local ram=$( free  | awk '/Mem/ {print (($3/$2)*100) }' | awk  ' {printf "%.0f", $1} ' )
    
    # DISK
    local disk=$( df  / | awk ' NR==2 {print $5}' | cut -d '%' -f 1 | awk '{printf "%.0f", $1}'  )
   
    # CPU
    local cpu=$( top -bn 1  | grep  -i "Cpu" | head -n 1 | awk ' {sum=$2+$4+$6} END {print sum}' | awk  ' {printf "%.0f", $1} ')
    
    if [[ $cpu -gt $cpu_threshold ]]; then
        alert "cpu"
        is_alert_needed=true
    fi
    
    if [[ $ram -gt $ram_threshold ]]; then
        alert "ram"
        is_alert_needed=true
    fi
    
    if [[ $disk -gt $disk_threshold ]]; then
        alert "disk"
        is_alert_needed=true
    fi
    
    if [[ $is_alert_needed == true ]]; then
        logging $ram $cpu $disk
    fi
    
}

check_resources

# crontab -e  * * * * * "/home/dilip/Projects/Bash Scripting/System Resource Sentinel/sentinel.sh"