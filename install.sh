#!/bin/bash

# Get the current directory of the install script
dir="$(pwd)"

# Install the uptime monitoring cron
(crontab -l ; echo "*/5 * * * * $dir/uptime.sh") | crontab -

# Install the uptime reporting cron
(crontab -l ; echo "59 23 28-31 * * $dir/gen_report.sh") | crontab -
