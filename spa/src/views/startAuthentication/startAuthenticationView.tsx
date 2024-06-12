import React, {useState} from 'react';
import {ErrorRenderer} from '../../utilities/errorRenderer';
import {StartAuthenticationProps} from './startAuthenticationProps';

export function StartAuthenticationView(props: StartAuthenticationProps) {

    const [errorText, setErrorText] = useState('');

    /*
     * Get the login URL and perform a full window redirect
     */
    async function execute() {

        try {

            // If required, you can supply extra OpenID Connect parameters that are whitelisted in the OAuth Agent configuration settings
            const whiteListedOptions = {
                /*extraAuthorizationParameters: {
                    ui_locales: 'sv'
                }*/
            };
            
            const response = await props.oauthClient.startLogin(whiteListedOptions);
            location.href = response.authorizationUrl;

        } catch (e: any) {

            setErrorText(ErrorRenderer.toDisplayFormat(e));
        }
    }

    return (
        <div className='container'>
            <h2>Start Authentication</h2>
            <p>The SPA asks the OAuth Agent for an Authorization Request URL, then manages its own redirect</p>
            <div>
                <button 
                    id='startAuthentication' 
                    className='btn btn-primary operationButton'
                    onClick={execute}
                    disabled={false}>
                        Sign In
                </button>
            </div>
            {errorText &&
            <div>
                <p className='alert alert-danger' id='getDataErrorResult'>{errorText}</p>
            </div>}
            <hr/>
        </div>
    )
}
