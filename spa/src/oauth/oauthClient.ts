import {OAuthAgentClient, SessionResponse, LogoutResponse} from '@curity/token-handler-js-assistant';
import {Configuration} from '../configuration';

/*
 * The entry point for making OAuth calls
 */
export class OAuthClient {

    private readonly oauthAgentClient: OAuthAgentClient;

    constructor(configuration: Configuration) {

        this.oauthAgentClient = new OAuthAgentClient({
            oauthAgentBaseUrl: `${configuration.bffBaseUrl}${configuration.oauthAgentPath}`,
        });
    }

    /*
     * On every page load the SPA asks the OAuth Agent for login related state
     */
    public async handlePageLoad(pageUrl: string): Promise<SessionResponse> {

        return await this.oauthAgentClient.onPageLoad(pageUrl);
    }

    /*
     * Invoked when the SPA wants to trigger a login redirect
     */
    public async startLogin(): Promise<string> {

        const response = await this.oauthAgentClient.startLogin({

            // If required the SPA can provide additional whitelisted parameters like this
            extraAuthorizationParameters: {
                // ui_locales: 'sv'
            }
        });

        return response.authorizationUrl;
    }

    /*
     * Get ID token claims from the API and return it to the UI for display
     */
    public async getClaims(): Promise<SessionResponse> {
        return await this.oauthAgentClient.session();
    }

    /*
     * Refresh the tokens stored in secure cookies when an API returns a 401 response
     */
    public async refresh(): Promise<void> {
        return await this.oauthAgentClient.refresh();
    }

    /*
     * Perform logout actions
     */
    public async logout(): Promise<LogoutResponse> {
        return await this.oauthAgentClient.logout();
    }
}
