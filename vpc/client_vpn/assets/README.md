```sh
% git clone https://github.com/OpenVPN/easy-rsa.git
% cd easy-rsa/easyrsa3 
% ./easyrsa init-pki
# create ca.crt
% ./easyrsa build-ca nopass
# create server.crt, server.key
% ./easyrsa --san=DNS:server build-server-full server nopass
# create client1.domain.tld.crt, client1.domain.tld.key
% ./easyrsa build-client-full client1.domain.tld nopass
% cp pki/ca.crt ./
% cp pki/issued/server.crt ./
% cp pki/private/server.key ./
% cp pki/issued/client1.domain.tld.crt ./
% cp pki/private/client1.domain.tld.key ./
% openssl x509 -in client1.domain.tld.crt -outform pem -out client1.domain.tld.pem