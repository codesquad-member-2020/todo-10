import { httpRequest } from '../utils/httpRequestUtil';
import { getEl, addClass } from '../utils/commonUtil';
import { URL } from '../contants/url';
import { COMMON_RULE, STATUS_KEY, TOKEN_KEY } from '../contants/constant';
import { drawLoading, drawLoginForm } from '../loginModule/tamplate';

const dimmedEl = getEl('#dimmed');

const checkUser = (data, callback) => {
    httpRequest.post(URL.DEV.LOGIN_API(), data).then((data) => {
        if (data.status !== STATUS_KEY.SUCCESS) return alert(data.content);
        dimmedEl.innerHTML = drawLoading();
        callback(TOKEN_KEY);
    });
};
const loginInit = () => {
    addClass(dimmedEl, COMMON_RULE.ACTIVE_KEY);
    dimmedEl.innerHTML = drawLoginForm();
};

export { checkUser, loginInit };
