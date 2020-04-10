import { getClosestEl } from '../util/commonUtil.js';
import { COMMON_RULES } from '../contants/constant.js';

function showColumnForm(target) {
    if (!target.classList.contains('toggle-form')) return;
    getClosestEl(target, '.todo-columns', '.todo-form').classList.toggle(COMMON_RULES.ACTIVE_KEY);
}

export {
    showColumnForm,
}