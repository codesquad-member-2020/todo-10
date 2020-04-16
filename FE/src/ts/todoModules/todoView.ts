import { getEl, getParentEl, removeClass } from '../utils/commonUtil';
import { timeSince } from '../utils/todoUtil';
import { COMMON_RULE } from '../contants/constant';
import { makeColumns, addCard, makeModal, makeMenu, injectLog } from './todoViewTemplate';

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

    renderTodoMenu({ content }): void {
        this.todoMenu.innerHTML = makeMenu(content);
    }

    addCardUpdate({ target }, { content }): void {
        const { card, card_count } = content;
        const currColumn = getParentEl(target, '.todo-columns');
        currColumn.querySelector('.card-wrap').innerHTML += addCard(card);
        currColumn.querySelector('.todo-count').innerHTML = card_count;
        removeClass(getParentEl(target, '.todo-form'), COMMON_RULE.ACTIVE_KEY);
        target.reset();
    }

    modifyCardUpdate(cardId, { content }): void {
        const { card } = content;
        this.todoApp.querySelector(`#card-${cardId} .card-contents`).innerHTML = card.content;
        removeClass(this.todoModal, COMMON_RULE.ACTIVE_KEY);
        this.todoModal.querySelector('form').reset();
    }

    addLogUpdate({ content }) {
        const logWrap = this.todoMenu.querySelector('.activity-log');
        injectLog(logWrap, content);
    }

    updateLogTimeData(logs) {
        logs.forEach(log => {
            const timeEl = log.querySelector('.log-time');
            const time = timeEl.dataset.time;
            timeEl.innerHTML = `${timeSince(new Date(time))} 전`;
        });
    }
}

export default TodoView;
