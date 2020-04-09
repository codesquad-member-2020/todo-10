import API_URL from '../contants/url'
import { getParentEl } from '../util/commonUtil';
import { httpRequest } from '../http/request';

function closeForm(target) {
    if (!target.classList.contains('btn-close')) return;
    target.closest('.todo-form').classList.toggle('active');
}

function submitForm(evt, callback) {
    evt.preventDefault();
    const column = getParentEl(evt.target, '.todo-columns');
    const columnId = column.dataset.columnId;
    const data = evt.target.querySelector('textarea').value;
    const url = `${API_URL}/mock/section/${columnId}/card`;
    httpRequest
        .post(url, { content: data })
        .then((data) => callback(evt, data));
}

export { closeForm, submitForm };
