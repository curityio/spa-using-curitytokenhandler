import React from 'react';

export function MultiTabView() {

    function getDescription(): string {
        return 'All browser tabs share SameSite cookies so users can run multiple tabs for the same SPA';
    }
    
    async function execute() {
        window.open(location.href);
    }

    return (
        <div className='container'>
            <h2>Multi Tab Browsing</h2>
            <p>{getDescription()}</p>
            <button 
                id='multiTab' 
                className='btn btn-primary operationButton'
                onClick={execute}>
                    Open New Browser Tab
            </button>
            <hr/>
        </div>
    )
}
