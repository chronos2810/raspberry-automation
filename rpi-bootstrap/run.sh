#!/bin/bash

: '
***********************************************************************

    ~ What to change? ~

- vars/main.yml: General variables to use during the playbook run

    ~ One-liner run ~

RUSER="raspbian-00"
RHOST="192.168.1.43"

# Without tags:
aplaybook -i "${RHOST}," -u "${RUSER}" --ask-pass ~/coding-repos/raspberry-automation/rpi-bootstrap/tests/playbook.yml 

# With tags: 
aplaybook -i "${RHOST}," -u "${RUSER}" --ask-pass ~/coding-repos/raspberry-automation/rpi-bootstrap/tests/playbook.yml -t zsh

***********************************************************************
'
