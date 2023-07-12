#!/bin/bash

set -x

sudo apt install ansible cowsay -y
sudo apt autoremove -y

mkdir -p ~/.ansible/roles
ln -s ~/coding-repos/raspberry-automation/rpi-bootstrap ~/.ansible/roles/rpi-bootstrap

ansible-playbook -i ~/coding-repos/raspberry-automation/rpi-bootstrap/tests/inventory ~/coding-repos/raspberry-automation/rpi-bootstrap/tests/playbook.yml --ask-become-pass
