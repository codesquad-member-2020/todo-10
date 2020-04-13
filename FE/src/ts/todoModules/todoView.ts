import { getEl, getParentEl, removeClass } from '../util/commonUtil';
import { COMMON_RULE } from '../contants/constant';
import { makeColumns, addCard, makeModal, makeMenu } from './todoViewTemplate';
import { ITodoViewTemplate } from '../interface/todoInterface';

class TodoView {
    public todoApp: HTMLElement;
    public todoMenu: HTMLElement;
    public todoModal: HTMLElement;

    constructor() {
        this.todoApp = getEl('#todo-app');
        this.todoMenu = getEl('#menu');
        this.todoModal = getEl('#modal');
    }

    todoAppRender({content}: ITodoViewTemplate): void {
        this.todoApp.innerHTML = makeColumns(content);
    }

    todoModalRender(): void {
        this.todoModal.innerHTML = makeModal();
    }

    todoMenuRender(): void {
        this.todoMenu.innerHTML = makeMenu();
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
