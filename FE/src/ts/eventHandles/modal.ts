import { URL } from '../contants/url.js';
import { COMMON_RULE } from '../contants/constant.js';
import { getParentEl, toggleClass } from '../util/commonUtil.js';
import { httpRequest } from '../http/request.js';

function closeModal(target) {
    return toggleClass({
        target: target,
        containsClassName: 'btn-close',
        closestClass: '#modal',
        toggleClassName: COMMON_RULE.ACTIVE_KEY,
    });
}

function submitModal(evt, modifyCardUpdate) {
    evt.preventDefault();
    const column = getParentEl(evt.target, '.modal-contents');
    const columnId = column.dataset.columnId;
    const cardId = column.dataset.cardId;
    const data = evt.target.querySelector('textarea').value;
    const url = `${URL.DEV.HOST}/mock/section/${columnId}/card/${cardId}`;
    httpRequest.patch(url, { content: data }).then((data) => modifyCardUpdate(cardId, data));
}

export { closeModal, submitModal };
