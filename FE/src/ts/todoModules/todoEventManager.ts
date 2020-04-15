import { COMMON_RULE } from '../contants/constant';
import { deleteCard, showEditModal, dragStartCard, dragoverCard, dragenterCard, dragendCard } from './eventHandles/card';
import { showColumnForm } from './eventHandles/column';
import { onClickSubmit } from './eventHandles/form';
import { checkDisabled } from '../utils/todoUtil';
import { getParentEl, toggleClass } from '../utils/commonUtil';
import TodoView from './todoView';

interface ITodoEventList {
    click: Function;
    submit: Function;
    input: Function;
}

interface ITodoAppEventList extends ITodoEventList {
    dblclick: Function;
    dragstart: Function;
    dragover: Function;
    dragenter: Function;
    dragend: Function;
}

class TodoEventManager {
    todoView: TodoView;
    todoAppEventList: ITodoAppEventList;
    todoModalEventList: ITodoEventList;
    constructor(todoView: TodoView) {
        this.todoView = todoView;
        this.todoAppEventList = {
            click: this.clickEventDelegation.bind(this),
            submit: this.submitEventDelegation.bind(this),
            dblclick: showEditModal.bind(this),
            dragstart: dragStartCard,
            dragover: dragoverCard,
            dragenter: dragenterCard,
            dragend: dragendCard,
            input: checkDisabled,
        };
        this.todoModalEventList = {
            click: this.clickEventDelegation.bind(this),
            submit: this.submitEventDelegation.bind(this),
            input: checkDisabled,
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

    clickEventDelegation({ target }:Event): void {
        const contentWrap = getParentEl(<HTMLElement>target, '.content-wrap');
        if (!contentWrap) return;
        switch (contentWrap.dataset.type) {
            case 'column':
                showColumnForm(<HTMLElement>target);
                break;
            case 'card':
                deleteCard(<HTMLElement>target);
                break;
            case 'form':
                toggleClass({
                    target: target,
                    containsClassName: 'btn-close',
                    closestClass: '.todo-form',
                    toggleClassName: COMMON_RULE.ACTIVE_KEY,
                });
                break;
            case 'modal-form':
                toggleClass({
                    target: target,
                    containsClassName: 'btn-close',
                    closestClass: '#modal',
                    toggleClassName: COMMON_RULE.ACTIVE_KEY,
                });
                break;
            default:
                break;
        }
    }

    submitEventDelegation(evt:Event): void {
        const contentWrap = getParentEl(<HTMLElement>evt.target, '.content-wrap');
        if (!contentWrap) return;
        switch (contentWrap.dataset.type) {
            case 'form':
                onClickSubmit({
                    event: evt,
                    parentClassName: '.todo-columns',
                    type: 'post',
                    callback: this.todoView.addCardUpdate,
                });
                break;
            case 'modal-form':
                onClickSubmit({
                    event: evt,
                    parentClassName: '.modal-contents',
                    type: 'patch',
                    callback: this.todoView.modifyCardUpdate.bind(this.todoView),
                });
                break;
            default:
                break;
        }
    }
}

export default TodoEventManager;
