#!/usr/bin/env bash
set -eo pipefail

date_formatted=$(date +'%Y-%m-%d %l:%M:%S %p')

battery_percentage=$(sudo tlp-stat -b | grep Charge | awk '{ print $3 }')
battery_status=$(sudo tlp-stat -b | grep status | awk '{ print $3 }')

echo "$date_formatted | $battery_percentage% - $battery_status"
