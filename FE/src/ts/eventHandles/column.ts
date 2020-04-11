import { getClosestEl } from '../util/commonUtil';
import { COMMON_RULE } from '../contants/constant';

function showColumnForm(target) {
    if (!target.classList.contains('toggle-form')) return;
    getClosestEl(target, '.todo-columns', '.todo-form').classList.toggle(COMMON_RULE.ACTIVE_KEY);
}

export {
    showColumnForm,
}