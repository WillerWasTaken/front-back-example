const express = require('express');
const rp = require('request-promise');

const app = express();
const port = 3000;
const backendUrl = process.env.BACKEND_URL;

if (!backendUrl) {
    throw new Error('No BACKEND_URL set for Front application');
}

console.log(`Backend url found in the configuration ${backendUrl}`);

app.get('/', async (req, res) => {
    try {
        htmlTemplate = await generateHtmlTemplate();
        res.writeHead(200, { 'Content-Type': 'text/html' });
        res.end(htmlTemplate);
    } catch (err) {
        res.writeHead(500, { 'Content-Type': 'text/html' });
        res.end('An error has occurred.');
        throw new Error(err);
    }
});

const server = app.listen(port, () => console.log(`Starting server on port ${port}.`));

const generateHtmlTemplate = async () => {
    user = await rp({ uri: `${backendUrl}/user`, json: true });
    return `
        <!DOCTYPE html>
        <html>
        <head>
            <meta charset="utf-8">
            <title>Simple front example</title>
        </head>
        <body>
            <div>Hello world</div>
            <div>The user name is ${user.name}</div>
        </body>
        </html>
    `;
};

module.exports = server;
