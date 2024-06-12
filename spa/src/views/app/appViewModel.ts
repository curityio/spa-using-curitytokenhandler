import {OAuthAgentClient, SessionResponse} from '@curity/token-handler-js-assistant';
import {ApiClient} from '../../api/apiClient';
import {Configuration} from '../../configuration';

export class AppViewModel {

    public configuration: Configuration | null;
    public oauthClient: OAuthAgentClient | null;
    public apiClient: ApiClient | null;
    public sessionResponse: SessionResponse | null;
    private isLoaded: boolean

    public constructor() {
        this.configuration = null;
        this.oauthClient = null;
        this.apiClient = null;
        this.sessionResponse = null;
        this.isLoaded = false;
    }

    /*
     * Download configuration from the web host to get the backend for frontend details
     */
    public async loadConfiguration(): Promise<void> {

        if (!this.isLoaded) {

            const configutationResponse = await fetch('config.json');
            this.configuration = await configutationResponse.json() as Configuration;
            this.oauthClient = new OAuthAgentClient({oauthAgentBaseUrl: `${this.configuration.bffBaseUrl}${this.configuration.oauthAgentPath}`});
            this.apiClient = new ApiClient(this.configuration, this.oauthClient);
            this.isLoaded = true;
        }
    }

    /*
     * Handle the page load event when the app loads
     */
    public async handlePageLoad(): Promise<void> {

        try {

            // Get the authentication state or process a login response
            this.sessionResponse =  await this.oauthClient!.onPageLoad(location.href);

        } finally {
            
            // If this is the callback URL, run post-login logic to remove OAuth details from the URL
            var url = new URL(location.href);
            if (url.pathname.toLowerCase() === '/callback') {
                history.replaceState({}, document.title, '/');
            }
        }
    }
}
