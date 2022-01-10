#!/bin/bash

set -x

sudo apt list --installed | grep -e ansible -e cowsay
RESULT=$?

if [ ${RESULT} -ne 0 ]; then
	sudo apt install ansible cowsay -y
	sudo apt autoremove -y
fi

# mkdir -p ~/.ansible/roles
# ln -s ~/raspberry-automation/rpi-bootstrap ~/.ansible/roles/rpi-bootstrap

cd ~/raspberry-automation/ansible

ansible all -i inventory/hosts.ini -m ping -u pi

ansible-playbook playbook.yml -i inventory/hosts.ini --ask-pass
