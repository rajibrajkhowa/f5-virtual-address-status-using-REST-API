#!/bin/bash

# Variables Passed As Arguments
F5_HOST=$1
F5_USER=$2
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
get_virtual_address_status
