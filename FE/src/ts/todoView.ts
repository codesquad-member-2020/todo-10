import { getEl } from './util/commonUtil.js';

class TodoView {
    constructor() {
        this.todoApp = getEl('#todo-app');
    }

    render(data) {
        this.todoApp.innerHTML = data.columns.reduce((acc, column) => {
            acc +=
                `<div class="todo-columns content-wrap" data-type="column" data-column-id="${column.id}" tabindex="0">
                    <div class="todo-title">
                    <h2><span class="todo-count">${column.cards.length}</span> ${column.title}</h2>
                    <div class="btn-wrap">
                        <button class="btn btn-toggle toggle-form"><span class="material-icons">add</span></button>
                        <button class="btn"><span class="material-icons">more_vert</span></button>
                    </div>
                    </div>
                    <div class="todo-form">
                        <form action="" class="content-wrap" data-type="form">
                            <input type="text" class="todo-input" placeholder="enter a note">
                            <textarea name="" id="" class="todo-textarea" cols="30" rows="10" maxlength="500" placeholder="enter a note"></textarea>
                            <div class="btn-wrap">
                            <button type="submit" class="btn btn-add" disabled="true">add</button>
                            <button type="reset" class="btn btn-close">cancel</button>
                            </div>
                        </form>
                    </div>
                    <div class="card-wrap">
                    ${this.makeCard(column.cards)}
                    </div>
                </div>`;
            return acc;
        }, '');
    }

    makeCard(cards) {
        return cards.reduce((acc, card) => {
            acc +=
                `<div class="card-item content-wrap" data-type="card" data-card-id="${card.id}" tabindex="0">
                    <div class="card-contents">${card.content}</div>
                    <p class="card-writer">added by <span>홍길동</span></p>
                    <button class="btn btn-close">
                    <span class="material-icons">close</span>
                    </button>
                </div>`;
            return acc;
        }, '');
    }

    update() {

    }
}

export default TodoView;