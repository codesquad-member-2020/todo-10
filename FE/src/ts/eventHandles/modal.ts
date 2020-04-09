import { API_URL } from '../contants/url';
import { getParentEl, toggleClass } from '../util/commonUtil';
import { httpRequest } from '../http/request';

function closeModal(target) {
    return toggleClass({
        target: target,
        containsClassName: 'btn-close',
        closestClass: '#modal',
        toggleClassName: 'active',
    });
}

function submitModal(evt, callback) {
    evt.preventDefault();
    const column = getParentEl(evt.target, '.modal-contents');
    const columnId = column.dataset.columnId;
    const cardId = column.dataset.cardId;
    const data = evt.target.querySelector('textarea').value;
    const url = `${API_URL}/mock/section/${columnId}/card/${cardId}`;
    httpRequest.patch(url, { content: data }).then((data) => callback({evt, data, columnId, cardId}));
}
export { closeModal, submitModal };
