
"""
# External
C:\Windows\System32\DisplaySwitch.exe /external
start "Steam" /b "steam://open/bigpicture"

# Internal
C:\Windows\System32\DisplaySwitch.exe /internal
taskkill.exe /F /IM Steam.exe /T
rundll32.exe user32.dll,LockWorkStation
"""

# ---------------------------------------------------------------------
#  Imports 
# ---------------------------------------------------------------------

from flask import Flask
import configparser

import subprocess
import sys

# ---------------------------------------------------------------------
#  Environment
# ---------------------------------------------------------------------

config = configparser.ConfigParser()
config.read('config.ini')

WIN_HOST = config['DEFAULT']['WIN_HOST']
WIN_USER = config['DEFAULT']['WIN_USER']
_COMMAND = config['DEFAULT']['_COMMAND']

# ---------------------------------------------------------------------
#  Functions
# ---------------------------------------------------------------------

def run_ssh_command(host, username, command):
    try:
        # Using subprocess to run the SSH command
        result = subprocess.run(
            [
                'ssh',
                f'{username}@{host}',
                '-o', 'StrictHostKeyChecking=no',  # Ignore host key checking
                command
            ],
            text=True,  # Return output as text
            capture_output=True  # Capture output for later use if needed
        )

        # Print the command output
        print(result.stdout)

    except Exception as e:
        print(f"Error running SSH command: {str(e)}", file=sys.stderr)

# ---------------------------------------------------------------------
#  Debug
# ---------------------------------------------------------------------

print('*** START_DEBUG ***\n')

# This makes sure that the SSH connection works, also that a first connection was established in order to have an $HOME/.ssh folder created
run_ssh_command(WIN_HOST, WIN_USER, 'whoami')

print('*** END_DEBUG ***\n')

# ---------------------------------------------------------------------
#  Create SSH Config
# ---------------------------------------------------------------------

# This step is not really neccesary, but it aids with manual ssh testing.

# Specify the path where you want to create the file
ssh_config_path = "/root/.ssh/config"

# Multiline content to be written to the file
ssh_config_content = f"""
# WIN SSH CONFIG
Host {WIN_HOST}
  User {WIN_USER}
  Hostname {WIN_HOST}
"""

# Open the file in write mode and write the content
with open(ssh_config_path, "w") as f:
    f.write(ssh_config_content)

# Now you can run:
#    docker exec -it wake-on-lan-flask-svc ssh 192.168.1.33 whoami

# ---------------------------------------------------------------------
#  Flask
# ---------------------------------------------------------------------

app = Flask(__name__)

@app.route('/tv')
def tv():
    # External display with no actions
    run_ssh_command(WIN_HOST, WIN_USER, 'psexec -s -i 1 \\\\%COMPUTERNAME% DisplaySwitch /external')
    return "Tv!"

@app.route('/steam')
def steam():
    # External display + open Steam
    run_ssh_command(WIN_HOST, WIN_USER, 'psexec -s -i 1 \\\\%COMPUTERNAME% DisplaySwitch /external')
    run_ssh_command(WIN_HOST, WIN_USER, 'psexec -s -i 1 \\\\%COMPUTERNAME% CMD /C START steam://open/bigpicture')
    return 'Steam!'

@app.route('/lock')
def lock():
    # Internal display + close Steam + lock screen
    run_ssh_command(WIN_HOST, WIN_USER, 'psexec -s -i 1 \\\\%COMPUTERNAME% DisplaySwitch /internal')
    run_ssh_command(WIN_HOST, WIN_USER, 'taskkill.exe /F /IM Steam.exe /T')
    run_ssh_command(WIN_HOST, WIN_USER, 'psexec -s -i 1 \\\\%COMPUTERNAME% psshutdown -l -t 0')
    return "Lock!"

# ---------------------------------------------------------------------
#  Main
# ---------------------------------------------------------------------

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
