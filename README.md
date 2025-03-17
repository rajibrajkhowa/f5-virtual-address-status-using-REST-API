# f5-virtual-address-status-using-REST-API
To extract the F5 virtual address status using REST API embedded in shell script. There are three versions of the scripts.

NB: Usually the VIP or Virtual Addresses are updated in F5 as "va_A.B.C.D" where A.B.C.D is the IPv4 address. So check the naming format of VIP in your F5 host so that you use the correct name in the arguments that you pass on to the script.
v1:
This is the simplest version that takes the script, user id, F5 hostname and virtual address as arguments.
./f5_va_status_v1 <User ID> <Target F5 Hostname> <Virtual Address/VIP>

eg. ./f5_va_status_v1 test TEST-F5 va_10.0.1.12

v2:
The v2 is essentially same as v1 but here we filter out the specific details viz, LB Hostname, LB VIP/Virtual Address and VIP/VA status from the returned JSON object using the utility "jq". This is helpful, if end user doesn't have any experience of handling F5 but just wants an intuitive output on VA/VIP status by running the REST API.

./f5_va_status_v2 <User ID> <Target F5 Hostname> <Virtual Address/VIP>

eg. ./f5_va_status_v2 test TEST-F5 va_10.0.1.12

v3:
This script takes in list of load balancers and VIPs/VAs and then loops over them to see which VAs/VIPs are configured in which load balancer and what is the status of the VA/VIP. Usually if we get a returned value of "null" under the status (i.e. "enabled" field) it indicates that specific VIP is not present in that LB. Otherwise it will return either "enabled": "yes" or "enabled": "no" to indicate UP or DOWN status respectively.

./f5_va_status_v3 <User ID>

eg. ./f5_va_status_v3 test

