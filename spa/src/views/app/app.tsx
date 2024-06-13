import React, {useEffect, useState} from 'react';
import {ErrorRenderer} from '../../utilities/errorRenderer';
import {MultiTabLogout} from '../../utilities/multiTabLogout';
import {CallApiView} from '../callApi/callApiView';
import {ClaimsView} from '../claims/claimsView';
import {MultiTabView} from '../multiTab/multiTabView';
import {PageLoadView} from '../pageLoad/pageLoadView';
import {SignOutView} from '../signOut/signOutView';
import {StartAuthenticationView} from '../startAuthentication/startAuthenticationView';
import {TitleView} from '../title/titleView';
import {UserInfoView} from '../userInfo/userInfoView';
import {AppProps} from './appProps';

/*
 * The application shell for the SPA demo app
 */
export default function App(props: AppProps) {

    const [isPageLoaded, setIsPageLoaded] = useState(false);
    const [isLoggedIn, setIsLoggedIn] = useState(false);
    const [pageLoadError, setPageLoadError] = useState('');
    const multiTabLogout = new MultiTabLogout(() => onExternalLogout());

    useEffect(() => {
        startup();
        return () => cleanup();
    }, []);

    /*
     * The SPA downloads configuration, then calls the OAuth agent to see if logged in or to handle login responses
     */
    async function startup() {

        window.addEventListener('storage', multiTabLogout.listenForLoggedOutEvent);
        await props.viewModel.loadConfiguration();

        try {
            await props.viewModel.handlePageLoad();
            setIsPageLoaded(true);
            setIsLoggedIn(props.viewModel.sessionResponse?.isLoggedIn || false);
            multiTabLogout.initialize();

        } catch (e: any) {
            setPageLoadError(ErrorRenderer.toDisplayFormat(e));
        }
    }

    /*
     * Free resources when the view unloads
     */
    function cleanup() {
        window.removeEventListener('storage', multiTabLogout.listenForLoggedOutEvent);
    }

    /*
     * When the user logs out, the SPA raises an event to other browser tabs
     */
    function onLoggedOut() {
        setIsLoggedIn(false);
        multiTabLogout.raiseLoggedOutEvent();
    }

    /*
     * When there is a logout in another browser tab, this SPA instance also moves to a logged out state
     */
    function onExternalLogout() {
        onLoggedOut();
    }

    /*
     * This simple app does not use React navigation and just renders the current view based on state
     */
    return (
        <>
            <TitleView />
            <PageLoadView
                isPageLoaded = {isPageLoaded}
                isLoggedIn = {isLoggedIn}
                pageLoadError = {pageLoadError} />

            {isPageLoaded &&
                <>
            
                    {/* Unauthenticated views */}
                    {!isLoggedIn &&
                        <StartAuthenticationView 
                            oauthClient={props.viewModel.oauthClient!} />
                    }

                    {/* Authenticated views */}
                    {isLoggedIn &&
                        
                        <>
                            <ClaimsView 
                                claims={props.viewModel.sessionResponse?.idTokenClaims} />

                            <CallApiView 
                                apiClient={props.viewModel.apiClient!}
                                onLoggedOut={() => onLoggedOut()} />

                            <UserInfoView 
                                apiClient={props.viewModel.apiClient!}
                                onLoggedOut={() => onLoggedOut()} />

                            <MultiTabView />

                            <SignOutView 
                                oauthClient={props.viewModel.oauthClient!}
                                onLoggedOut={() => onLoggedOut()} />
                        </>
                    }

                </>
            }
        </>
    );
}
