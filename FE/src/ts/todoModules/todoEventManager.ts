import { deleteCard, showEditModal, dragStartCard, dragoverCard, dragenterCard, dragendCard } from '../eventHandles/card';
import { showColumnForm } from '../eventHandles/column';
import { closeForm, submitForm } from '../eventHandles/form';
import { closeModal, submitModal } from '../eventHandles/modal';
import { checkDisabled } from '../util/todoUtil';
import { getParentEl } from '../util/commonUtil';

class TodoEventManager {
    constructor(module) {
        this.todoView = module.todoView;
    }

    todoAppEventInit(): void {
        this.todoView.todoApp.addEventListener('click', this.clickEventDelegation.bind(this));
        this.todoView.todoApp.addEventListener('submit', this.submitEventDelegation.bind(this));
        this.todoView.todoApp.addEventListener('dblclick', showEditModal.bind(this));
        this.todoView.todoApp.addEventListener('dragstart', dragStartCard);
        this.todoView.todoApp.addEventListener('dragover', dragoverCard);
        this.todoView.todoApp.addEventListener('dragenter', dragenterCard);
        this.todoView.todoApp.addEventListener('dragend', dragendCard);
        this.todoView.todoApp.addEventListener('input', checkDisabled);
    }

    todoModalEventInit(): void {
        this.todoView.todoModal.addEventListener('click', this.clickEventDelegation.bind(this));
        this.todoView.todoModal.addEventListener('submit', this.submitEventDelegation.bind(this));
        this.todoView.todoModal.addEventListener('input', checkDisabled);
    }

    clickEventDelegation({ target }): void {
        const contentWrap = getParentEl(target, '.content-wrap');
        if (!contentWrap) return;
        switch (contentWrap.dataset.type) {
            case 'column':
                showColumnForm(target);
                break;
            case 'card':
                deleteCard(target);
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

    submitEventDelegation(evt): void {
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
