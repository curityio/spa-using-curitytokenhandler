import React from 'react';
import {ClaimsProps} from './claimsProps';

export function ClaimsView(props: ClaimsProps) {

    function getAuthenticationTime(): string {

        if (!props.claims) {
            return 'No ID token claims issued';
        }

        return `auth_time: ${new Date(props.claims.auth_time * 1000)}`
    }

    return (

        <div className='container'>
            <h2>Get ID Token Claims</h2>
            <p>The SPA gets its ID token claims from the OAuth Agent when the page loads</p>
            <div>
                <p id='getClaimsResult' className='alert alert-success'>{getAuthenticationTime()}</p>
            </div>
            <hr/>
        </div>
    )
}
