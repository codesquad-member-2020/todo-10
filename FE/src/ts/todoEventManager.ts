import { deleteCard, showEditModal, dragStartCard, dragoverCard, dragenterCard, dragendCard } from './eventHandles/card.js';
import { isEmpty } from './util/commonUtil';
import { showColumnForm } from './eventHandles/column.js';
import { closeForm, submitForm } from './eventHandles/form.js';
import { closeModal, submitModal } from './eventHandles/modal';

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
        this.todoView.todoApp.addEventListener('dblclick', showEditModal);
        this.todoView.todoApp.addEventListener('dragstart', dragStartCard);
        this.todoView.todoApp.addEventListener('dragover', dragoverCard);
        this.todoView.todoApp.addEventListener('dragenter', dragenterCard);
        this.todoView.todoApp.addEventListener('dragend', dragendCard);
        this.todoView.todoApp.addEventListener('input', this.checkDisabled.bind(this));
    }

    todoModalEventInit() {
        this.todoView.todoModal.addEventListener('input', this.checkDisabled.bind(this));
        this.todoView.todoModal.addEventListener('submit', this.modalHandler.bind(this));
        this.todoView.todoModal.addEventListener('click', this.clickModal.bind(this));
    }

    modalHandler(evt) {
        submitModal(evt, function ({ evt, data, columnId, cardId }) {
            document.querySelector(`#column-${columnId} #card-${cardId} .card-contents`)?.innerHTML = data.content.content;
            document.querySelector('#modal')?.classList.remove('active');
            document.querySelector('#modal textarea').value = '';
        });
    }

    clickModal({ target }) {
        closeModal(target);
    }

    checkDisabled({ target }) {
        const contentWrap = target.closest('.content-wrap');
        const btn = contentWrap.querySelector('.btn-add');
        return isEmpty(target.value) ? (btn.disabled = true) : (btn.disabled = false);
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
                submitForm(evt, this.todoView.update);
                break;
            default:
                break;
        }
    }
}

export default TodoEventManager;
