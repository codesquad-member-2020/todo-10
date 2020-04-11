import { URL } from '../contants/url';
import { COMMON_RULE } from '../contants/constant';
import { getParentEl, toggleClass } from '../util/commonUtil';
import { httpRequest } from '../http/request';

function closeModal(target: HTMLElement) {
    return toggleClass({
        target: target,
        containsClassName: 'btn-close',
        closestClass: '#modal',
        toggleClassName: COMMON_RULE.ACTIVE_KEY,
    });
}

function submitModal(evt: Event, modifyCardUpdate: Function) {
    evt.preventDefault();
    const column: HTMLElement = getParentEl(evt.target, '.modal-contents');
    const columnId = column.dataset.columnId;
    const cardId = column.dataset.cardId;
    const data = evt.target.querySelector('textarea').value;
    const url = `${URL.MOCKUP.BASE}/mock/section/${columnId}/card/${cardId}`;
    httpRequest.patch(url, { content: data }).then((data) => modifyCardUpdate(cardId, data));
}

export { closeModal, submitModal };
