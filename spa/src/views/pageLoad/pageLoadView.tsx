import React from 'react';
import {PageLoadProps} from './pageLoadProps';

export function PageLoadView(props: PageLoadProps) {

    function getAuthenticationState(): string {

        if (!props.isPageLoaded) {
            return 'Page loading ...';
        } else if (props.isLoggedIn) {
            return 'You are authenticated';
        } else {
            return 'Authentication required';
        }
    }

    return (
        
        <div className='container'>
            <div>
                <h2>Page Load</h2>
                <p>When the SPA loads it asks the OAuth Agent for its Authenticated State and to handle an Authorization Response if required</p>
                <div>
                    <p className='alert alert-success' id='pageLoadResult'>{getAuthenticationState()}</p>
                </div>
                {props.pageLoadError &&
                <div>
                    <p className='alert alert-danger' id='pageLoadErrorResult'>{props.pageLoadError}</p>
                </div>}
                <hr/>
            </div>
        </div>
    )
}
