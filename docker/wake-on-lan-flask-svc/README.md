
# Walkthrough

## Step 0: Windows SSH enablement

- This enables the OpenSSH server on the Windows machine, so it's listening for new connections 

```powershell
# Enable SSH on Windows: https://learn.microsoft.com/en-us/windows-server/administration/openssh/openssh_install_firstuse?tabs=gui
# 1. Install OpenSSH

# Install the OpenSSH Client
Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0

# Install the OpenSSH Server
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0

# 2. Start the service and configure the firewall rules

# Start the sshd service
Start-Service sshd

# OPTIONAL but recommended:
Set-Service -Name sshd -StartupType 'Automatic'

# Confirm the Firewall rule is configured. It should be created automatically by setup. Run the following to verify
if (!(Get-NetFirewallRule -Name "OpenSSH-Server-In-TCP" -ErrorAction SilentlyContinue | Select-Object Name, Enabled)) {
    Write-Output "Firewall Rule 'OpenSSH-Server-In-TCP' does not exist, creating it..."
    New-NetFirewallRule -Name 'OpenSSH-Server-In-TCP' -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
} else {
    Write-Output "Firewall rule 'OpenSSH-Server-In-TCP' has been created and exists."
}
```

- Up to here, we've enabled the OpenSSH server to listen on the Windows machine, now we have to create an SSH key in the client machine.

```bash
# 4. On the Linux machine run:

# Create the key
ssh-keygen -t rsa -f ~/.ssh/win-desktop

# Add the key to the ssh agent
eval $(ssh-agent -s)
ssh-add ~/.ssh/win-desktop

# You can delete the key (Since it's now added to the ssh agent), this step is optional... Bear in mind that if the ssh-agent stops working for any reason, you'll have to create a new key if you don't have the old key stored somewhere else
rm ~/.ssh/win-desktop

# Copy the public key contents from the Linux machine to the Windows machine
scp ~/.ssh/win-desktop.pub angus@192.168.1.33:.ssh/win-desktop.pub

# 6. SSH to the Windows machine and run the following:

# SSH with password
ssh angus@192.168.1.33 powershell
	# IF using password based auth, use the account password (Outlook)

# Get the public key file generated previously on your client
$authorizedKey = Get-Content -Path $env:USERPROFILE\.ssh\win-desktop.pub

# Generate the PowerShell to be run remote that will copy the public key file generated previously on your client to the authorized_keys file on your server
Add-Content -Force -Path $env:ProgramData\ssh\administrators_authorized_keys -Value $authorizedKey
icacls.exe "$env:ProgramData\ssh\administrators_authorized_keys" /inheritance:r /grant "Administrators:F" /grant "SYSTEM:F"
```

- All set! Test with:

```
# 5. Login from your Linux machine without password:
ssh angus@192.168.1.33 whoami
```

## Step 1: Utility to copy the code to the Raspberry

```bash
# Copy to raspberry:
cd docker/wake-on-lan-flask-svc
rsync -av --delete --progress ../../docker raspbian-00@192.168.1.43:.
```

## Step 2: Docker SSH Agent Forwarding

```bash
# On the Linux machine:

# 0. Add the key to the ssh agent
eval $(ssh-agent -s)
ssh-add ~/.ssh/win-desktop

# 1. Add the config for the Windows SSH login to $HOME/.ssh/config
cat << EOT >> $HOME/.ssh/config

# WIN SSH Config
Host <WIN_IP>
  User <WIN_USERNAME> # Example: foobar
  Hostname <WIN_IP>
  IdentityFile ~/.ssh/win-desktop
  ForwardAgent yes
EOT

# 2. Create the docker-compose.yaml file with the following values:
...
    environment:
      - SSH_AUTH_SOCK=/ssh-agent
    volumes:
      - $SSH_AUTH_SOCK:/ssh-agent
...

# 3. Create the container and test it with:
docker-compose up -d --build
```

```
# 1. Install tools psexec, psshutdown by copying the executables to C:\Windows\System32\
#       https://learn.microsoft.com/es-es/sysinternals/downloads/psexec
#       https://learn.microsoft.com/es-es/sysinternals/downloads/psshutdown

# 2. Run commands with psexec
psexec -s -i 1 \\%COMPUTERNAME% psshutdown -l -t 0
```
