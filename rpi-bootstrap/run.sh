#!/bin/bash

: '
***********************************************************************

    ~ What to change? ~

- tests/inventory: Checks where this the playbook is going to run, remote over ssh or local?
- vars/main.yml: General variables to use during the playbook run
- files/resolv.conf and files/dhcpcd.conf: IP and DNS related configuration

    ~ One-liner run ~

RUSER="raspbian-00"
RHOST=192.168.1.43
aplaybook -i "${RHOST}," -u "${RUSER}" --ask-pass ~/coding-repos/raspberry-automation/rpi-bootstrap/tests/playbook.yml 
	# Does this needs "--ask-become-pass"?

***********************************************************************
'

set -x

sudo apt install ansible cowsay -y
sudo apt autoremove -y

mkdir -p ~/.ansible/roles
ln -s ~/coding-repos/raspberry-automation/rpi-bootstrap ~/.ansible/roles/rpi-bootstrap

ansible-playbook -i ~/coding-repos/raspberry-automation/rpi-bootstrap/tests/inventory ~/coding-repos/raspberry-automation/rpi-bootstrap/tests/playbook.yml --ask-become-pass
