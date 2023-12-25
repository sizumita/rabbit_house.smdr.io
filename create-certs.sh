sudo ipsec pki --gen --type rsa --size 4096 --outform pem > ./ansible/files/certificate/strongSwan/ca-key.pem
sudo ipsec pki --self --ca --lifetime 3650 --in ./ansible/files/certificate/strongSwan/ca-key.pem --type rsa --dn "CN=Rabbit House VPN root CA" --outform pem > ./ansible/files/certificate/strongSwan/ca-cert.pem

sudo ipsec pki --gen --type rsa --size 4096 --outform pem > ./ansible/files/certificate/strongSwan/server-key.pem
pki --in ./ansible/files/certificate/strongSwan/server-key.pem --type rsa \
  | pki --issue --lieftime 1825 \
  --cacert ./ansible/files/certificate/strongSwan/ca-cert.pem \
  --cakey ./ansible/files/certificate/strongSwan/ca-key.pem \
  --dn "CN=rabbit_house.smdr.io" --san rabbit_house.smdr.io \
  --flag serverAuth --flag ikeIntermediate --outform pem \
  > ./ansible/files/certificate/strongSwan/server-cert.pem
