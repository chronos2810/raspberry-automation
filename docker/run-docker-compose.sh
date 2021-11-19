#!/bin/bash

set -x
cd ~/raspberry-automation/docker/pi-hole
docker-compose up -d

cd ~/raspberry-automation/docker/samba
docker-compose up -d
