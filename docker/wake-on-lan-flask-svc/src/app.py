# **************
#  Imports 
# **************

from flask import Flask
import os
import configparser

# **************
#  Environment
# **************

config = configparser.ConfigParser()
config.read('config.ini')

WIN_HOST = config['DEFAULT']['WIN_HOST']
WIN_USER = config['DEFAULT']['WIN_USER']

# **************
#  Debug
# **************

# print(WIN_HOST, WIN_USER)

# **************
#  Functions
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
