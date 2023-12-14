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

@app.route('/run')
def run():
    # os.system('cmd /k 'C:\Windows\System32\DisplaySwitch.exe /external'')
    # os.system('cmd /k 'C:\Program Files (x86)\Steam\Steam.exe -gamepadui'')
    # os.system('start 'Steam' /b 'steam://open/bigpicture'')
    # os.system('env')
    return 'test'

@app.route('/stop')
def shutdown():
    # os.system('cmd /k 'C:\Windows\System32\DisplaySwitch.exe /internal'')
    # os.system('cmd /k 'taskkill.exe /F /IM Steam.exe /T'')
    return 'stop'

# ---------------------------------------------------------------------
#  Main
# ---------------------------------------------------------------------

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
