#!/bin/bash

set -x
cd ~/raspberry-automation/docker/pi-hole
docker-compose up -d
docker-compose ps

cd ~/raspberry-automation/docker/samba
mkdir ~/media
docker-compose up -d
docker-compose ps
