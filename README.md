# OpenVPN-Client-Config-Script
OpenVPN Client Config Script to Inline the required certificates into the generated <client>.ovpn config file
# this is a modified version of the original inline script as found here: 
# https://www.webhi.com/how-to/how-to-install-openvpn-server-on-linux-debian-11-12/


# First argument: Client identifier
# execute the script, where the first argument passed after will be the client name to add to openvpn and generate the client's ovpn config file
# this was tested generating clients and configs running with the root user 

# create client certificates then copy them to the openvpn servers client dir

# change the inline field tls-crypt-v2 or tls-crypt for ta2 or ta ddos protection
