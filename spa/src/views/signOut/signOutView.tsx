import React, {useState} from 'react';
import {ErrorRenderer} from '../../utilities/errorRenderer';
import {SignOutProps} from './signOutProps';

export function SignOutView(props: SignOutProps) {

    const [errorText, setErrorText] = useState('');
    
    async function execute() {

        try {

            const logoutResponse = await props.oauthClient.logout();
            props.onLoggedOut();
            if (logoutResponse.logoutUrl) {
                location.href = logoutResponse.logoutUrl;
            } else {
                location.href = location.origin
            }

        } catch (e: any) {

            // A 401 from OAuth Agent endpoints only occurs if cookie encryption keys have been renewed
            if (e.status === 401) {
                props.onLoggedOut();
                return;
            }

            setErrorText(ErrorRenderer.toDisplayFormat(e));
        }
    }

    return (
        <div className='container'>
            <h2>Sign Out</h2>
            <p>The SPA asks the OAuth Agent for an End Session Request URL, then manages its own redirect</p>
            <button 
                id='signOut' 
                className='btn btn-primary operationButton'
                onClick={execute}>
                    Sign Out
            </button>
            {errorText &&
            <div>
                <p className='alert alert-danger' id='signOutErrorResult'>{errorText}</p>
            </div>}
            <hr/>
        </div>
    )
}
