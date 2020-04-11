import { getEl, getParentEl, removeClass } from './util/commonUtil.js';
import { COMMON_RULE } from './contants/constant.js';

class TodoView {
    constructor() {
        this.todoApp = getEl('#todo-app');
        this.todoModal = getEl('#modal');
    }

    render(data) {
        this.todoApp.innerHTML = data.content.sections.reduce((acc, column) => {
            acc +=
                `<div class="todo-columns content-wrap" data-type="column" id="column-${column.id}" data-column-id=${column.id} tabindex="0">
                <div class="todo-title">
                <h2><span class="todo-count">${column.cards.length}</span> ${column.title}</h2>
                <div class="btn-wrap">
                    <button class="btn btn-toggle toggle-form"><span class="material-icons">add</span></button>
                    <button class="btn"><span class="material-icons">more_vert</span></button>
                </div>
                </div>
                <div class="todo-form content-wrap" data-type="form">
                    <form action="">
                        <input type="text" class="todo-input" placeholder="enter a note">
                        <textarea name="" id="" class="todo-textarea" cols="30" rows="10" maxlength="500" placeholder="enter a note"></textarea>
                        <div class="btn-wrap">
                        <button type="submit" class="btn btn-add" disabled="true">add</button>
                        <button type="reset" class="btn btn-close">cancel</button>
                        </div>
                    </form>
                </div>
                <div class="card-wrap">
                ${this.makeCards(column.cards)}
                </div>
            </div>`;
            return acc;
        }, '');
    }

    makeCards(cards) {
        return cards.reduce((acc, card) => {
            acc +=
                `<div class="card-item content-wrap" draggable="true" data-type="card" id="card-${card.id}" data-card-id="${card.id}" tabindex="0">
                <div class="card-contents">${card.content}</div>
                <p class="card-writer">added by <span>홍길동</span></p>
                <button class="btn btn-close">
                    <span class="material-icons">close</span>
                </button>
            </div>`;
            return acc;
        }, '');
    }

    addCardUpdate({ target }, { content: data }) {
        const currColumn = getParentEl(target, '.todo-columns');
        currColumn.querySelector('.card-wrap').innerHTML +=
            `<div class="card-item content-wrap" draggable="true" data-type="card" id="card-${data.id}" data-card-id="${data.id}" tabindex="0">
                <div class="card-contents">${data.content}</div>
                <p class="card-writer">added by <span>홍길동</span></p>
                <button class="btn btn-close">
                    <span class="material-icons">close</span>
                </button>
            </div>`;
        currColumn.querySelector('.todo-count').innerHTML++;
        removeClass(getParentEl(target, '.todo-form'), COMMON_RULE.ACTIVE_KEY);
        target.reset();
    }

    modifyCardUpdate(cardId, { content: data }) {
        this.todoApp.querySelector(`#card-${cardId} .card-contents`).innerHTML = data.content;
        removeClass(this.todoModal, COMMON_RULE.ACTIVE_KEY);
        this.todoModal.querySelector('form').reset();
    }
}

export default TodoView;
