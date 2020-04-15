import { getEl, getParentEl, removeClass } from '../utils/commonUtil';
import { COMMON_RULE } from '../contants/constant';
import { makeColumns, addCard, makeModal, makeMenu } from './todoViewTemplate';

class TodoView {
    public todoHeader: HTMLElement;
    public todoApp: HTMLElement;
    public todoMenu: HTMLElement;
    public todoModal: HTMLElement;

    constructor() {
        this.todoHeader = getEl('#todo-header');
        this.todoApp = getEl('#todo-app');
        this.todoMenu = getEl('#menu');
        this.todoModal = getEl('#modal');
    }

    renderTodoApp({ content }): void {
        this.todoApp.innerHTML = makeColumns(content);
    }

    renderTodoModal(): void {
        this.todoModal.innerHTML = makeModal();
    }

    renderTodoMenu(logData): void {
        this.todoMenu.innerHTML = makeMenu(logData);
    }

    addCardUpdate({ target }, { content: card }): void {
        const currColumn = getParentEl(target, '.todo-columns');
        currColumn.querySelector('.card-wrap').innerHTML += addCard(card.id, card.content);
        currColumn.querySelector('.todo-count').innerHTML++;
        removeClass(getParentEl(target, '.todo-form'), COMMON_RULE.ACTIVE_KEY);
        target.reset();
    }

    modifyCardUpdate(cardId, { content: card }): void {
        this.todoApp.querySelector(`#card-${cardId} .card-contents`).innerHTML = card.content;
        removeClass(this.todoModal, COMMON_RULE.ACTIVE_KEY);
        this.todoModal.querySelector('form').reset();
    }
}

export default TodoView;
