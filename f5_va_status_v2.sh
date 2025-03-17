#!/bin/bash

# Variables Passed As Arguments
F5_USER=$1
F5_NODE=$2
F5_PASS=$(<password.txt)
VIRTUAL_ADDRESS=$3

# Function to get the status of a virtual address
get_virtual_address_status() {
    curl -sk -u $F5_USER:$F5_PASS \
    -H "Content-Type: application/json" \
    -X GET "https://$F5_HOST/mgmt/tm/ltm/virtual-address/$VIRTUAL_ADDRESS"
}

echo


# Call the function
VIP_STATUS=$(get_virtual_address_status | jq '.enabled' | tr -d '"')

jq -nc \

--arg lb_host "$F5_HOST"\
--arg vip "$VIRTUAL_ADDRESS" \
--arg vip_status "$VIP_STATUS" \
'{
   "LB HOST": $lb_host,
   "VIP": $vip,
   "VIP_ENABLED": $vip_status
  }'
