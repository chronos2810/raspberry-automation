#!/bin/bash

set -x
cd ~/docker/pi-hole
docker-compose up -d

cd ~/docker/samba
docker-compose up -d
