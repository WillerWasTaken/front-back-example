# Backend example application

This is an example of a simple backend application written in Python with flask.

## Requirements

- virtualenv with python3

```
pip install -r requirements.txt
```

## Launching test

```
python -m unittest tests/*.py
```

## Launching the server

The USER_NAME environment variable must be set before launching the server.
The value of this variable is then returned by the API.

```
export USER_NAME=John
python server.py
```

## Endpoints

```
/ : Hello endpoint
/user : Retrieves user information
```
