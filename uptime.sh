#!/bin/bash

log_file=uptime.log
router_ip=192.168.1.1
dns_servers=("8.8.8.8" "1.1.1.1")

# Check to ensure we're not already running
if pidof -o %PPID -x "uptime.sh" >/dev/null; then
	echo "Script is already running." >> $log_file
	exit 1
fi

while true; do
  # Check the connection to the router
  if ping -c 1 $router_ip > /dev/null; then
    echo "`date`: Router is up" >> $log_file
    for dns_server in "${dns_servers[@]}"; do
      # Check the connection to the internet
      if ping -c 1 $dns_server > /dev/null; then
        echo "`date`: Network is up using $dns_server " >> $log_file
        break
      fi
    done
    if [ $dns_server == ${dns_servers[-1]} ]; then
      echo "`date`: Network is down" >> $log_file
    fi
  else
    echo "`date`: Router is down" >> $log_file
  fi
  sleep 30
done

