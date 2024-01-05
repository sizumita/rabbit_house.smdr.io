NAME="$1"

ipsec pki --gen --type rsa --size 2048 --outform pem > ./ansible/files/certificate/strongSwan/client-key-$NAME.pem
ipsec pki --pub --in ./ansible/files/certificate/strongSwan/client-key-$NAME.pem --type rsa \
  | ipsec pki --issue --lifetime 730 --outform pem \
  --cacert ./ansible/files/certificate/strongSwan/ca-cert.pem \
  --cakey ./ansible/files/certificate/strongSwan/ca-key.pem \
  --dn "C=CH, O=strongSwan, CN=$NAME" \
  --san $NAME \
  > ./ansible/files/certificate/strongSwan/client-cert-$NAME.pem

openssl pkcs12 -export -name "Rabbit House VPN Certificate" \
  -inkey ./ansible/files/certificate/strongSwan/client-key-$NAME.pem \
  -in ./ansible/files/certificate/strongSwan/client-cert-$NAME.pem \
  -certfile ./ansible/files/certificate/strongSwan/ca-cert.pem \
  -caname "Rabbit House VPN root CA" \
  -out Client-$NAME.p12 -legacy
