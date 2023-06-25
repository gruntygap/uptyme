#!/bin/bash

log_file=uptime.log
month=$(date +%b)
year=$(date +%Y)
report_file="uptime_report_$month-$year.txt"

# Initialize counters
router_up_count=0
router_down_count=0
internet_up_count=0
internet_down_count=0

# Read the log file and count the number of "up" and "down" occurrences
router_up_count=$(grep -a "$month.*$year.*Router is up" $log_file | wc -l)
router_down_count=$(grep -a "$month.*$year.*Router is down" $log_file | wc -l)
internet_up_count=$(grep -a "$month.*$year.*Network is up" $log_file | wc -l)
internet_down_count=$(grep -a "$month.*$year.*Network is down" $log_file | wc -l)

# Calculate the uptime percentage
router_uptime=$(echo "scale=2; $router_up_count / ($router_up_count + $router_down_count) * 100" | bc)
internet_uptime=$(echo "scale=2; $internet_up_count / ($internet_up_count + $internet_down_count) * 100" | bc)

router_up_min=$(echo "scale=2; $router_up_count / 2" | bc)
router_down_min=$(echo "scale=2; $router_down_count / 2" | bc)
internet_up_min=$(echo "scale=2; $internet_up_count / 2" | bc)
internet_down_min=$(echo "scale=2; $internet_down_count / 2" | bc)

# Write the report to the report file
echo "Monthly Uptime Report for $month $year" > $report_file
echo "Router Uptime: $router_uptime%" >> $report_file
echo "Total Router Up: $router_up_count (~$router_up_min minute(s))" >> $report_file
echo "Total Router Down: $router_down_count (~$router_down_min minute(s))" >> $report_file
echo "Internet Uptime: $internet_uptime%" >> $report_file
echo "Total Internet Up: $internet_up_count (~$internet_up_min minute(s))" >> $report_file
echo "Total Internet Down: $internet_down_count (~$internet_down_min minute(s))" >> $report_file

