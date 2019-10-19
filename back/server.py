import os
from flask import Flask
app = Flask(__name__)


@app.route('/')
def home():
    res = {
        'msg': 'Hello from the API application'
    }
    return res

@app.route('/user')
def user_name():
    user = {
        'name': USER_NAME
    }
    return user

if __name__ == '__main__':
    USER_NAME = os.environ.get("USER_NAME")
    if not USER_NAME:
        raise ValueError("No USER_NAME set for Flask application")
    print(f'User name found in the configuration {USER_NAME}')
    app.run(host= '0.0.0.0')
