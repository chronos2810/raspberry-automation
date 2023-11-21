
## Windows SSH enablement

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

# 4. On the Linux machine run:

# Create the key
ssh-keygen -t rsa -f ~/.ssh/win-desktop

# Add the key to the ssh agent
eval $(ssh-agent -s)
ssh-add ~/.ssh/win-desktop

# Delete the key (Since it's now added to the ssh agent)
rm ~/.ssh/win-desktop

# Copy the public key contents
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

# 5. Login from your Linux machine without password with:
ssh angus@192.168.1.33 powershell
```

# Docker

```bash
# Copy to raspberry:
rsync -avz --delete ../../docker raspbian-00@192.168.1.43:docker
```
