import { URL } from '../contants/url';
import { COMMON_RULE } from '../contants/constant';
import { getParentEl, toggleClass } from '../util/commonUtil';
import { httpRequest } from '../http/request';

function closeForm(target: HTMLElement) {
    return toggleClass({
        target: target,
        containsClassName: 'btn-close',
        closestClass: '.todo-form',
        toggleClassName: COMMON_RULE.ACTIVE_KEY,
    });
}

function submitForm(evt: Event, addCardUpdate: Function) {
    evt.preventDefault();
    const column: HTMLElement = getParentEl(evt.target, '.todo-columns');
    const columnId = column.dataset.columnId;
    const data = evt.target.querySelector('textarea').value;
    const url = `${URL.DEV.HOST}/mock/section/${columnId}/card`;
    httpRequest.post(url, { content: data }).then((data) => addCardUpdate(evt, data));
}

export { closeForm, submitForm };
