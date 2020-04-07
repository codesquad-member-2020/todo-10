import { getElement } from './util/commonUtil.js';
import { cardClick } from './events/card.js';


class TodoEventManager {
    constructor(module) {
        this.todoView = module.todoView;
        this.module = module;
    }

    init() {
        this.todoView.todoApp.addEventListener('click', this.clickEventDelegation.bind(this));
    }

    clickEventDelegation({ target }) {
        const testNode = target.closest('.TEST');
        if (!testNode) return;
        switch (testNode.dataset.type) {
            case 'column': this.columnClick(target);
                break;
            case 'card': cardClick(target);
                break;
            default: break;
        }
    }

    columnClick(target) {
        if (!target.parentElement.classList.contains('toggle-form')) return;
        target.closest('.TEST').querySelector('.todo-form').classList.toggle('active');
    }
}

export default TodoEventManager;