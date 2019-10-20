# Frontend example application

This is an example of a simple front application written in Node with express.
The application will display an html front page with data retrieved from the backend.

## Requirements

- Node

```
npm install
```

## Launching test

```
npm test
```

## Launching the server

The BACKEND_URL environment variable must be set before launching the server.
The value of this variable is used to retrieve data from the API.

```
export BACKEND_URL=http://url-to-the-backend
node server.js
```
