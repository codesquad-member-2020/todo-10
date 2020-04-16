import { httpRequest } from '../utils/httpRequestUtil';
import { getEl, addClass } from '../utils/commonUtil';
import { URL } from '../contants/url';
import { COMMON_RULE, STATUS_KEY } from '../contants/constant';
import { drawLoading, drawLoginForm } from './tamplate';

class Login {
    constructor(todoController) {
        this.todoController = todoController;
        this.dimmedEl = getEl('#dimmed');
        this.token = null;
    }

    checkToken() {
        this.token = sessionStorage.getItem('TODO-TOKEN');
    }

    checkUser(data) {
        httpRequest.login(URL.DEV.LOGIN_API(), data).then((data) => {
            if (data.status !== STATUS_KEY.SUCCESS) return alert(data.content);
            this.dimmedEl.innerHTML = drawLoading();
        });
    }

    loginInit() {
        addClass(this.dimmedEl, COMMON_RULE.ACTIVE_KEY);
        this.dimmedEl.innerHTML = drawLoginForm();
    }

    loginHandler() {
        this.dimmedEl.querySelector('.btn').addEventListener('click', (e) => {
            e.preventDefault();
            const loginIdEl = <HTMLInputElement>getEl('#userID');
            const loginPwEl = <HTMLInputElement>getEl('#password');
            const data = {
                name: loginIdEl.value,
                password: loginPwEl.value,
            };
            this.checkUser(data);
        });
    }
}

export default Login;
