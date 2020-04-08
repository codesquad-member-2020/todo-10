import { cardClickHandle, cardDblclickHandle, cardDragStartHandle, cardDragover, cardDrop } from './eventHandles/card.js';
import { columnClickHandle } from './eventHandles/column.js';
import { formClickHandle, formSubmitHandle } from './eventHandles/form.js';

class TodoEventManager {
    constructor(module) {
        this.todoView = module.todoView;
        this.todoModel = module.todoModel;
    }

    init() {
        this.todoView.todoApp.addEventListener('click', this.clickEventDelegation.bind(this));
        this.todoView.todoApp.addEventListener('dblclick', cardDblclickHandle);
        this.todoView.todoApp.addEventListener('submit', this.submitEventDelegation.bind(this));
        this.todoView.todoApp.addEventListener('dragstart', cardDragStartHandle);
        this.todoView.todoApp.addEventListener('dragover', cardDragover);
        this.todoView.todoApp.addEventListener('drop', cardDrop);
    }

    clickEventDelegation({ target }) {
        const contentWrap = target.closest('.content-wrap');
        if (!contentWrap) return;
        switch (contentWrap.dataset.type) {
            case 'column': columnClickHandle(target);
                break;
            case 'card': cardClickHandle(target, this.todoModel.deleteCardRequest);
                break;
            case 'form': formClickHandle(target);
                break;
            default: break;
        }
    }

    submitEventDelegation(evt) {
        switch (evt.target.dataset.type) {
            case 'form': formSubmitHandle(evt);
                break;
            default: break;
        }
    }
}

export default TodoEventManager;