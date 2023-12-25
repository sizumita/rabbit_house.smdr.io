sudo apt-get update
sudo apt-get upgrade
sudo apt-get software-properties-common
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install ansible -y

ansible-galaxy collection install community.general
ansible-playbook ansible/playbook.yml
