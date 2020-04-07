import { getElement } from './util/commonUtil.js';
class TodoView {
    constructor() {
        this.todoApp = getElement('#todo-app');
    }
    render(data) {
        this.todoApp.innerHTML = data.columns.reduce((acc, column) => {
            acc +=
                `<div class="todo-columns TEST" data-type="column" data-column-id="${column.id}" tabindex="0">
                    <div class="todo-title">
                    <h2><span class="todo-count">${column.cards.length}</span> ${column.title}</h2>
                    <div class="btn-wrap">
                        <button class="btn btn-toggle toggle-form"><span class="material-icons">add</span></button>
                        <button class="btn"><span class="material-icons">more_vert</span></button>
                    </div>
                    </div>
                    <div class="todo-form">
                        <form action="">
                            <textarea name="" id="" class="todo-textarea" cols="30" rows="10" maxlength="500"></textarea>
                            <div class="btn-wrap">
                            <button class="btn btn-add">add</button>
                            <button class="btn btn-close">cancel</button>
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
                `<div class="card-item TEST"  data-type="card" data-card-id="${card.id}" tabindex="0">
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
