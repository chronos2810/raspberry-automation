# raspberry-automation

Raspberry Pi Ansible and Docker files

- Usage:

```bash
# Change default password
passwd

# Clone the repo
cd ~
sudo apt update && sudo apt install git
git clone https://github.com/chronos2810/raspberry-automation.git

# Run the scripts
cd raspberry-automation

# Pi bootstrap
rpi-bootstrap/run.sh

# Change the password in the .env files inside each folder previous to run the scripts
vim docker/pi-hole/.env
vim docker/samba/.env

# Docker compose up
docker/run-docker-compose.sh
```
