import { getClosestEl } from '../util/commonUtil.js';

function showColumnForm(target) {
    if (!target.classList.contains('toggle-form')) return;
    getClosestEl(target, '.todo-columns', '.todo-form').classList.toggle('active');
}

export {
    showColumnForm,
}