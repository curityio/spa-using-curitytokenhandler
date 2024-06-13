import {ApiClient} from '../../api/apiClient';

export interface UserInfoProps {
    apiClient: ApiClient;
    onLoggedOut: () => void;
}
