import { getClosestEl } from '../../utils/commonUtil';
import { COMMON_RULE } from '../../contants/constant';

function showColumnForm(target: HTMLElement) {
    if (!target.classList.contains('toggle-form')) return;
    getClosestEl(target, '.todo-columns', '.todo-form').classList.toggle(COMMON_RULE.ACTIVE_KEY);
}

export {
    showColumnForm,
}