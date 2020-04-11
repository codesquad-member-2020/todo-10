import { deleteCard, showEditModal, dragStartCard, dragoverCard, dragenterCard, dragendCard } from './eventHandles/card.js';
import { showColumnForm } from './eventHandles/column.js';
import { closeForm, submitForm } from './eventHandles/form.js';
import { closeModal, submitModal } from './eventHandles/modal.js';
import { checkDisabled } from './util/todoUtil.js';
import { getParentEl } from './util/commonUtil.js';

class TodoEventManager {
    constructor(module) {
        this.todoView = module.todoView;
        this.todoModel = module.todoModel;
    }

    init() {
        this.todoAppEventInit();
        this.todoModalEventInit();
    }

    todoAppEventInit() {
        this.todoView.todoApp.addEventListener('click', this.clickEventDelegation.bind(this));
        this.todoView.todoApp.addEventListener('submit', this.submitEventDelegation.bind(this));
        this.todoView.todoApp.addEventListener('dblclick', showEditModal.bind(this));
        this.todoView.todoApp.addEventListener('dragstart', dragStartCard);
        this.todoView.todoApp.addEventListener('dragover', dragoverCard);
        this.todoView.todoApp.addEventListener('dragenter', dragenterCard);
        this.todoView.todoApp.addEventListener('dragend', dragendCard);
        this.todoView.todoApp.addEventListener('input', checkDisabled);
    }

    todoModalEventInit() {
        this.todoView.todoModal.addEventListener('click', this.clickEventDelegation.bind(this));
        this.todoView.todoModal.addEventListener('submit', this.submitEventDelegation.bind(this));
        this.todoView.todoModal.addEventListener('input', checkDisabled);
    }

    clickEventDelegation({ target }) {
        const contentWrap = getParentEl(target, '.content-wrap');
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
            case 'modal-form':
                closeModal(target);
                break;
            default:
                break;
        }
    }

    submitEventDelegation(evt) {
        const contentWrap = getParentEl(evt.target, '.content-wrap');
        if (!contentWrap) return;
        switch (contentWrap.dataset.type) {
            case 'form':
                submitForm(evt, this.todoView.addCardUpdate);
                break;
            case 'modal-form':
                submitModal(evt, this.todoView.modifyCardUpdate.bind(this.todoView));
                break;
            default:
                break;
        }
    }
}

export default TodoEventManager;
