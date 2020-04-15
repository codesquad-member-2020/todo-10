import { URL } from '../../contants/url';
import { getParentEl } from '../../utils/commonUtil';
import { httpRequest } from '../../utils/httpRequestUtil';

interface IOnClickSubmit {
    event: Event;
    parentClassName: string;
    type: string;
    callback: Function;
}

function onClickSubmit({ event, parentClassName, type, callback }: IOnClickSubmit) {
    event.preventDefault();
    const target = <HTMLElement>event.target;
    const parentEl = getParentEl(target, parentClassName);
    const columnId = parentEl.dataset.columnId || null;
    const cardId = parentEl.dataset.cardId || null;
    const textareaEl = target.querySelector('textarea');
    const textareaValue = textareaEl?.value;
    let apiURL = null;

    switch (type) {
        case 'post':
            apiURL = `${URL.MOCKUP.BASE}/mock/section/${columnId}/card`;
            httpRequest.post(apiURL, { content: textareaValue }).then((data) => callback(event, data));
            break;
        case 'patch':
            apiURL = `${URL.MOCKUP.BASE}/mock/section/${columnId}/card/${cardId}`;
            httpRequest.patch(apiURL, { content: textareaValue }).then((data) => callback(cardId, data));
            break;
    }
}

export { onClickSubmit };
