import { URL } from '../contants/url';
import { getParentEl } from '../util/commonUtil';
import { httpRequest } from '../http/request';

function onClickSubmit({ event, parentClassName, type, callback }) {
    event.preventDefault();
    const parentEl = getParentEl(event.target, parentClassName);
    const columnId = parentEl.dataset.columnId || null;
    const cardId = parentEl.dataset.cardId || null; //
    const textareaValue = event.target.querySelector('textarea').value;
    let apiURL = null;

    switch (type) {
        case 'post':
            apiURL = `${URL.MOCKUP.BASE}/mock/section/${columnId}/card`;
            debugger;
            httpRequest.post(apiURL, { content: textareaValue }).then((data) => callback(event, data));
            break;
        case 'patch':
            apiURL = `${URL.MOCKUP.BASE}/mock/section/${columnId}/card/${cardId}`;
            httpRequest.patch(apiURL, { content: textareaValue }).then((data) => callback(cardId, data));
            break;
    }
}

export { onClickSubmit };
