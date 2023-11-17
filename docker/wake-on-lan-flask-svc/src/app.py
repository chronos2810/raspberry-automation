from flask import Flask

app = Flask(__name__)

@app.route('/run')
def run():
    return 'Run!'

@app.route('/shutdown')
def shutdown():
    return 'Shutdown!'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
