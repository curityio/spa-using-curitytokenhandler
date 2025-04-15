import express from 'express';
import fs from 'fs';
import https from 'https';
import {Configuration} from './configuration';

/*
 * First load configuration
 */
const configurationJson = fs.readFileSync('config.json', 'utf8');
const configuration = JSON.parse(configurationJson) as Configuration;

/*
 * Write security headers when a request is first received
 */
const app = express();
app.use((request: express.Request, response: express.Response, next: express.NextFunction) => {

    let policy = "default-src 'none';";
    policy += " script-src 'self';";
    policy += ` connect-src 'self' ${configuration.bffBaseUrl};`;
    policy += " child-src 'self';";
    policy += " img-src 'self';";
    policy += " style-src 'self' https://cdn.jsdelivr.net;";
    policy += ` font-src 'self';`;
    policy += " object-src 'none';";
    policy += " frame-ancestors 'none';";
    policy += " base-uri 'self';";
    policy += " form-action 'self';";

    response.setHeader('content-security-policy', policy);
    response.setHeader('strict-transport-security', 'max-age=31536000; includeSubdomains; preload');
    response.setHeader('x-frame-options', 'DENY');
    response.setHeader('x-xss-protection', '1; mode=block');
    response.setHeader('x-content-type-options', 'nosniff');
    response.setHeader('referrer-policy', 'same-origin');

    next();
});

/*
 * Then serve static content
 */
app.use(express.static('./content'));

/*
 * Handle not found routes like /callback by serving the default document
 */
app.get('/*_', (request: express.Request, response: express.Response) => {
    response.sendFile('index.html', {root: './content'});
});

/*
 * Start listening on either HTTP or HTTPS, depending on configuration
 */
if (configuration.keystoreFilePath) {

    const keystore = fs.readFileSync(configuration.keystoreFilePath);
    const sslOptions = {
        pfx: keystore,
        passphrase: configuration.keystorePassword,
    };

    const httpsServer = https.createServer(sslOptions, app);
    httpsServer.listen(configuration.port, () => {
        console.log(`Web host is listening on HTTPS port ${configuration.port}`);
    });

} else {

    app.listen(configuration.port, () => {
        console.log(`Web host is listening on HTTP port ${configuration.port}`);
    });
}
