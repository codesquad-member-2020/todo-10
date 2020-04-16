import { httpRequest } from '../utils/httpRequestUtil';
import { getEl, addClass } from '../utils/commonUtil';
import { URL } from '../contants/url';
import { COMMON_RULE, STATUS_KEY } from '../contants/constant';
import { drawLoading, drawLoginForm } from './tamplate';

class Login {
    constructor(loginCallBack) {
        this.loginCallBack = loginCallBack;
        this.token = sessionStorage.getItem('TODO-TOKEN');
        this.dimmedEl = getEl('#dimmed');
        this.logoutEl = getEl('#logout');
        this.logoutEl.addEventListener('click', this.logout);
    }

    checkToken() {
        return this.token ? true : false;
    }

    loginInit() {
        addClass(this.dimmedEl, COMMON_RULE.ACTIVE_KEY);
        this.dimmedEl.innerHTML = drawLoginForm();
        this.dimmedEl.querySelector('.btn').addEventListener('click', this.loginHandler.bind(this));
    }

    loginHandler(e) {
        e.preventDefault();
        const loginIdEl = <HTMLInputElement>getEl('#userID');
        const loginPwEl = <HTMLInputElement>getEl('#password');
        const data = { name: loginIdEl.value, password: loginPwEl.value };
        httpRequest.login(URL.DEV.LOGIN_API(), data).then(this.checkUser.bind(this));
    }

    checkUser(data) {
        if (data.status !== STATUS_KEY.SUCCESS) return alert(data.content);
        this.dimmedEl.innerHTML = drawLoading();
        this.loginCallBack();
    }

    logout() {
        sessionStorage.removeItem('TODO-TOKEN');
        location.reload();
    }
}

export default Login;
