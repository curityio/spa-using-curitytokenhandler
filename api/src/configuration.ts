export interface Configuration {
    port: number;
    jwksUri: string;
    issuer: string;
    audience: string;
    keystoreFilePath: string;
    keystorePassword: string;
};
