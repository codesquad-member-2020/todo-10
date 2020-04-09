import { deleteCard, showEditModal, dragStartCard, dragoverCard, dragenterCard, dropCard } from './eventHandles/card.js';
import { showColumnForm } from './eventHandles/column.js';
import { closeForm, submitForm, isDisabledBtn } from './eventHandles/form.js';

class TodoEventManager {
    constructor(module) {
        this.todoView = module.todoView;
        this.todoModel = module.todoModel;
    }

    init() {
        this.todoView.todoApp.addEventListener('click', this.clickEventDelegation.bind(this));
        this.todoView.todoApp.addEventListener('submit', this.submitEventDelegation.bind(this));
        this.todoView.todoApp.addEventListener('dblclick', showEditModal);
        this.todoView.todoApp.addEventListener('dragstart', dragStartCard);
        this.todoView.todoApp.addEventListener('dragover', dragoverCard);
        this.todoView.todoApp.addEventListener('dragenter', dragenterCard);
        this.todoView.todoApp.addEventListener('drop', dropCard);
        this.todoView.todoApp.addEventListener('input', this.checkDisabled.bind(this));
    }

    checkDisabled({ target }) {
        const contentWrap = target.closest('.content-wrap');
        const btn = contentWrap.querySelector('.btn-add');
        isDisabledBtn(target) ? (btn.disabled = true) : (btn.disabled = false);
    }

    clickEventDelegation({ target }) {
        const contentWrap = target.closest('.content-wrap');
        if (!contentWrap) return;
        switch (contentWrap.dataset.type) {
            case 'column':
                showColumnForm(target);
                break;
            case 'card':
                deleteCard(target, this.todoModel.deleteCardRequest);
                break;
            case 'form':
                closeForm(target);
                break;
            default:
                break;
        }
    }

    submitEventDelegation(evt) {
        const contentWrap = evt.target.closest('.content-wrap');
        if (!contentWrap) return;
        switch (contentWrap.dataset.type) {
            case 'form':
                submitForm(evt);
                break;
            default:
                break;
        }
    }
}

export default TodoEventManager;
