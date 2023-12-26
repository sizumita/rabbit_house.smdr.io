systemctl stop dnsmasq
systemctl restart systemd-resolved
ansible-playbook ansible/playbook.yml
sudo systemctl restart tinc@gsnet.service
