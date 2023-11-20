from flask import Flask
import os

app = Flask(__name__)


@app.route('/run')
def run():
    # os.system('cmd /k "C:\Windows\System32\DisplaySwitch.exe /external"')
    # os.system('cmd /k "C:\Program Files (x86)\Steam\Steam.exe -gamepadui"')
    # os.system('start "Steam" /b "steam://open/bigpicture"')
    return "test"


@app.route('/stop')
def shutdown():
    os.system('cmd /k "C:\Windows\System32\DisplaySwitch.exe /internal"')
    os.system('cmd /k "taskkill.exe /F /IM Steam.exe /T"')
    return "asdf"


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
