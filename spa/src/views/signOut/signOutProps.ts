import {OAuthAgentClient} from '@curity/token-handler-js-assistant';

export interface SignOutProps {
    oauthClient: OAuthAgentClient;
    onLoggedOut: () => void;
}
