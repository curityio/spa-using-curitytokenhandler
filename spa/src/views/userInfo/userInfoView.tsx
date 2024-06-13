import React, {useState} from 'react';
import {ErrorRenderer} from '../../utilities/errorRenderer';
import {SessionExpiredError} from '../../utilities/sessionExpiredError';
import {UserInfoProps} from './userInfoProps';

export function UserInfoView(props: UserInfoProps) {

    const [userName, setUserName] = useState('');
    const [errorText, setErrorText] = useState('');

    async function execute() {
        
        try {

            let userInfo = await props.apiClient.getOAuthUserInfo();
            setErrorText('');
            
            if (userInfo.given_name && userInfo.family_name) {
                setUserName(`${userInfo.given_name} ${userInfo.family_name}`);
            } else {
                setUserName('No username details returned from userinfo');
            }

        } catch (e: any) {

            if (e instanceof SessionExpiredError) {
                props.onLoggedOut();
                return;
            }

            setErrorText(ErrorRenderer.toDisplayFormat(e));
        }
    }

    return (

        <div className='container'>
            <h2>Get User Info</h2>
            <p>The SPA can get OAuth User Info by making an API request using SameSite cookies</p>
            <button 
                id='getUserInfo' 
                className='btn btn-primary operationButton'
                onClick={execute}>
                    Get User Info
            </button>
            {userName &&
            <div>
                <p id='getUserInfoResult' className='alert alert-success'>{userName}</p>
            </div>}
            {errorText &&
            <div>
                <p className='alert alert-danger' id='getUserInfoErrorResult'>{errorText}</p>
            </div>}
            <hr/>
        </div>
    )
}
