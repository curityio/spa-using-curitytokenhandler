import {OAuthAgentClient} from '@curity/token-handler-js-assistant';
import {Configuration} from '../configuration';
import {ApiRemoteError} from '../utilities/apiRemoteError';
import {SessionExpiredError} from '../utilities/sessionExpiredError';

/*
 * The entry point for making calls to APIs after authentication
 */
export class ApiClient {

    private readonly configuration: Configuration;
    private readonly oauthClient: OAuthAgentClient;

    public constructor(configuration: Configuration, oauthClient: OAuthAgentClient) {

        this.configuration = configuration;
        this.oauthClient = oauthClient;
    }

    /*
     * Call the example API with a secure cookie as a credential
     */
    public async getWelcomeData(): Promise<any> {
        return await this.fetch('POST', `${this.configuration.apiPath}/data`);
    }

    /*
     * Call the OAuth user info endpoint with a secure cookie as a credential
     */
    public async getOAuthUserInfo(): Promise<any> {
        return await this.fetch('GET', `${this.configuration.oauthUserinfoPath}`);
    }

    /*
     * Call an API and handle expired access tokens or expired refresh tokens
     */
    private async fetch(method: string, path: string): Promise<any> {

        try {

            // Make an API request that transports an access token to APIs via a secure cookie
            return await this.fetchImpl(method, path);

        } catch (e1: any) {

            if (e1.status !== 401) {
                throw e1;
            }

            try {

                // Handle 401s by asking the OAuth agent to refresh the access token in the secure cookie
                await this.oauthClient.refresh();

            } catch (e2: any) {

                // // Session expiry condition 1: a 401 during token refresh
                if (e2.status == 401) {
                    throw new SessionExpiredError();
                }
            }
            
            try {

                // Retry the API call with rewritten cookies
                return await this.fetchImpl(method, path);

            } catch (e3: any) {

                if (e3.status !== 401) {
                    throw e3;
                }

                // Session expiry condition 2: a 401 can mean cookies in the browser use an old encryption key
                throw new SessionExpiredError();
            }
        }
    }

    /*
     * Send a request with a secure cookie - the 'token-handler-version' header ensures a preflight OPTIONS request
     */
    private async fetchImpl(method: string, path: string): Promise<any> {

        const url = `${this.configuration.bffBaseUrl}${path}`;
        const init = {
            credentials: 'include',
            headers: {
                accept: 'application/json',
                'token-handler-version': '1',
            },
            method: method,
            mode: 'cors',
        } as RequestInit;

        const response = await fetch(url, init);
        if (response.ok) {
            return await response.json();
        }

        const contentType = response.headers.get('content-type');
        if (contentType && contentType.indexOf('application/json') !== -1) {

            const remoteError = await this.processErrorResponse(response);
            throw remoteError;

        } else {

            throw new ApiRemoteError(response.status, 'server_error', response.statusText);
        }
    }

    /*
     * The SPA interacts with a few different backend errors via its gateway, so handle expected responses
     */
    private async processErrorResponse(response: Response): Promise<ApiRemoteError> {

        let code = 'server_error';
        let details = '';
        const errorResponse = await response.json();

        if (errorResponse.code) {

            // Can be returned by API gateway plugins
            code = errorResponse.code;

        } else if (errorResponse.error_code) {
            
            // Can be returned by the OAuth agent
            code = errorResponse.error_code;
        }

        if (errorResponse.message) {

            // Can be returned by API gateway plugins
            details = errorResponse.message;

        } else if (errorResponse.detailed_error) {
            
            // Can be returned by the OAuth agent
            details = errorResponse.detailed_error;
        }

        return new ApiRemoteError(response.status, code, details);
    }
}
