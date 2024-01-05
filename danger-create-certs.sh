y "really create new certs?"
rm -rf ansible/files/certificate/strongSwan/*.pem
rm -rf Client.p12
sudo ipsec pki --gen --type rsa --size 4096 --outform pem > ./ansible/files/certificate/strongSwan/ca-key.pem
sudo ipsec pki --self --ca --lifetime 3650 --in ./ansible/files/certificate/strongSwan/ca-key.pem --type rsa --dn "CN=Rabbit House VPN root CA" --outform pem > ./ansible/files/certificate/strongSwan/ca-cert.pem

sudo ipsec pki --gen --type rsa --size 4096 --outform pem > ./ansible/files/certificate/strongSwan/server-key.pem
sudo ipsec pki --pub --in ./ansible/files/certificate/strongSwan/server-key.pem --type rsa \
  | pki --issue --lifetime 1825 \
  --cacert ./ansible/files/certificate/strongSwan/ca-cert.pem \
  --cakey ./ansible/files/certificate/strongSwan/ca-key.pem \
  --dn "CN=rabbit-house.smdr.io" --san rabbit-house.smdr.io \
  --flag serverAuth --flag ikeIntermediate --outform pem \
  > ./ansible/files/certificate/strongSwan/server-cert.pem

ipsec pki --gen --type rsa --size 2048 --outform pem > ./ansible/files/certificate/strongSwan/client-key.pem
ipsec pki --pub --in ./ansible/files/certificate/strongSwan/client-key.pem --type rsa \
  | ipsec pki --issue --lifetime 730 --outform pem \
  --cacert ./ansible/files/certificate/strongSwan/ca-cert.pem \
  --cakey ./ansible/files/certificate/strongSwan/ca-key.pem \
  --dn "C=CH, O=strongSwan, CN=sumito@izumita.com" \
  --san sumito@izumita.com \
  > ./ansible/files/certificate/strongSwan/client-cert.pem

openssl pkcs12 -export -name "Rabbit House VPN Certificate" \
  -inkey ./ansible/files/certificate/strongSwan/client-key.pem \
  -in ./ansible/files/certificate/strongSwan/client-cert.pem \
  -certfile ./ansible/files/certificate/strongSwan/ca-cert.pem \
  -caname "Rabbit House VPN root CA" \
  -out Client.p12 -legacy
