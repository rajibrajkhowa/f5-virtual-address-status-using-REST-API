#!/bin/bash

F5_USER=$1
F5_PASS=$(<password.txt)

lb_data="lb.txt"
vip_data="vip.txt"

while read F5_HOST; do
   while read VIRTUAL_ADDRESS; do
     get_virtual_address_status() {
          curl -sk -u $F5_USER:$F5_PASS \
         -H "Content-Type: application/json" \
         -X GET "https://$F5_HOST/mgmt/tm/ltm/virtual-address/$VIRTUAL_ADDRESS"
     }
	 VIP_STATUS=$(get_virtual_address_status | jq '.enabled' | tr -d '"')
     sleep 2
     jq -nc \
      --arg lb_host "$F5_HOST"\
      --arg vip "$VIRTUAL_ADDRESS" \
      --arg vip_status "$VIP_STATUS" \
     '{
        "LB HOST": $lb_host,
        "VIP": $vip,
        "VIP_ENABLED": $vip_status
      }' >> output.txt
   done < $vip_data
done < $lb_data
