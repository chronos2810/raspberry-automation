#!/bin/bash

set -x

sudo apt install ansible cowsay -y

mkdir -p ~/.ansible/roles
ln -s ~/ansible/rpi-bootstrap ~/.ansible/roles/rpi-bootstrap

ansible-playbook -i ~/ansible/rpi-bootstrap/tests/inventory ~/ansible/rpi-bootstrap/tests/playbook.yml --ask-become-pass
