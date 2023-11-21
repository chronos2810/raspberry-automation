# **************
#  Imports 
# **************

from flask import Flask
import configparser

import subprocess
import sys

# **************
#  Environment
# **************

config = configparser.ConfigParser()
config.read('config.ini')

WIN_HOST = config['DEFAULT']['WIN_HOST']
WIN_USER = config['DEFAULT']['WIN_USER']
_COMMAND = config['DEFAULT']['_COMMAND']

# **************
#  Debug
# **************

# print(WIN_HOST, WIN_USER)

# **************
#  Functions
# **************

def run_ssh_command(host, username, command):
    try:
        # Using subprocess to run the SSH command
        result = subprocess.run(
            [
                'ssh',
                f'{username}@{host}',
                '-o', 'StrictHostKeyChecking=no',  # Ignore host key checking (for demo purposes, not recommended in production)
                command
            ],
            text=True,  # Return output as text
            capture_output=True  # Capture output for later use if needed
        )

        # Print the command output
        print(result.stdout)

    except Exception as e:
        print(f"Error running SSH command: {str(e)}", file=sys.stderr)

run_ssh_command(WIN_HOST, WIN_USER, _COMMAND)

# **************
#  Flask
# **************

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

# **************
#  Main
# **************

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
