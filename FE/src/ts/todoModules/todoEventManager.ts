import { deleteCard, showEditModal, dragStartCard, dragoverCard, dragenterCard, dragendCard } from '../eventHandles/card';
import { showColumnForm } from '../eventHandles/column';
import { closeForm, submitForm } from '../eventHandles/form';
import { closeModal, submitModal } from '../eventHandles/modal';
import { checkDisabled } from '../util/todoUtil';
import { getParentEl } from '../util/commonUtil';

class TodoEventManager {
    constructor({ todoView }) {
        this.todoView = todoView;
        this.todoAppEventList = {
            'click': this.clickEventDelegation.bind(this),
            'submit': this.submitEventDelegation.bind(this),
            'dblclick': showEditModal.bind(this),
            'dragstart': dragStartCard,
            'dragover': dragoverCard,
            'dragenter': dragenterCard,
            'dragend': dragendCard,
            'input': checkDisabled,
        };
        this.todoModalEventList = {
            'click': this.clickEventDelegation.bind(this),
            'submit': this.submitEventDelegation.bind(this),
            'input': checkDisabled,
        };
    }

    todoAppEventInit(): void {
        for (let [event, callback] of Object.entries(this.todoAppEventList)) {
            this.todoView.todoApp.addEventListener(event, callback);
        }
    }

    todoModalEventInit(): void {
        for (let [event, callback] of Object.entries(this.todoModalEventList)) {
            this.todoView.todoModal.addEventListener(event, callback);
        }
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
