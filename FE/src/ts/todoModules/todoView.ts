import { getEl, getParentEl, removeClass } from '../util/commonUtil';
import { COMMON_RULE } from '../contants/constant';
import { makeColumns, addCard } from './todoViewTemplate';

class TodoView {
    constructor() {
        this.todoApp = getEl('#todo-app');
        this.todoModal = getEl('#modal');
    }

    todoAppRender({ content }) {
        this.todoApp.innerHTML = makeColumns(content);
    }

    addCardUpdate({ target }, { content: card }) {
        const currColumn = getParentEl(target, '.todo-columns');
        currColumn.querySelector('.card-wrap').innerHTML += addCard(card.id, card.content);
        currColumn.querySelector('.todo-count').innerHTML++;
        removeClass(getParentEl(target, '.todo-form'), COMMON_RULE.ACTIVE_KEY);
        target.reset();
    }

    modifyCardUpdate(cardId, { content: card }) {
        this.todoApp.querySelector(`#card-${cardId} .card-contents`).innerHTML = card.content;
        removeClass(this.todoModal, COMMON_RULE.ACTIVE_KEY);
        this.todoModal.querySelector('form').reset();
    }
}

export default TodoView;
