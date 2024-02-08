
#!/usr/bin/bash
# First argument: Client identifier
# modified version of the inline script as found here: 
# https://www.webhi.com/how-to/how-to-install-openvpn-server-on-linux-debian-11-12/

# execute the script, where the first argument passed after will be the client name to add to openvpn and generate the client's ovpn config file
# this was tested generating clients and configs running with the root user 
#echo $0
KEY_DIR=/etc/openvpn/server
CLIENT_DIR=/etc/openvpn/client
OUTPUT_DIR=/etc/easy-rsa
BASE_CONFIG=/etc/openvpn/client/tulsi-client-no-comments.conf
TA_KEY=${KEY_DIR}/ta.key
TA2_KEY=${CLIENT_DIR}/ta2-client.key

#create client certificates then copy them to the openvpn servers client dir
cd /etc/easy-rsa #change to easy-rsa dir
./easyrsa build-client-full ${1} nopass #generate client certificates within easy-rsa
mkdir /etc/openvpn/client/${1} #make dir for client files
cp -rp /etc/easy-rsa/pki/{issued/${1}.crt,private/${1}.key} ${CLIENT_DIR}/${1} #copy client certs to openvpn client dir

# change the inline field tls-crypt-v2 or tls-crypt for ta2 or ta ddos protection
cat ${BASE_CONFIG} \
    <(echo -e '<ca>') \
    ${KEY_DIR}/ca.crt \
    <(echo -e '</ca>\n<cert>') \
    ${CLIENT_DIR}/${1}/${1}.crt \
    <(echo -e '</cert>\n<key>') \
    ${CLIENT_DIR}/${1}/${1}.key \
    <(echo -e '</key>\n<tls-crypt-v2>') \
    ${TA2_KEY} \
    <(echo -e '</tls-crypt-v2>') \
    > ${OUTPUT_DIR}/${1}.ovpn


#TODO: add cleanup here
