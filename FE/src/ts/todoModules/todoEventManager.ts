import { COMMON_RULE } from '../contants/constant';
import { deleteCard, showEditModal, dragStartCard, dragoverCard, dragenterCard, dragendCard } from './eventHandles/card';
import { showColumnForm } from './eventHandles/column';
import { onClickSubmit } from './eventHandles/form';
import { showMenu, closeMenu } from './eventHandles/menu';
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
        this.todoHeaderEventList = {
            click: showMenu.bind(this),
        };
        this.todoMenuEventList = {
            click: closeMenu.bind(this),
        }
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

    initTodoEvent(): void {
        const events = [
            { target: this.todoView.todoHeader, eventList: this.todoHeaderEventList },
            { target: this.todoView.todoMenu, eventList: this.todoMenuEventList },
            { target: this.todoView.todoApp, eventList: this.todoAppEventList },
            { target: this.todoView.todoModal, eventList: this.todoModalEventList },
        ];
        events.forEach(event => this.registerEvent(event));
    }

    registerEvent({ target, eventList }) {
        for (let [event, callback] of Object.entries(eventList)) {
            target.addEventListener(event, callback);
        }
    }

    clickEventDelegation({ target }: Event): void {
        const contentWrap = getParentEl(<HTMLElement>target, '.content-wrap');
        if (!contentWrap) return;
        switch (contentWrap.dataset.type) {
            case 'column':
                showColumnForm(<HTMLElement>target);
                break;
            case 'card':
                deleteCard({
                    target: target,
                    logCallBack: this.todoView.addLogUpdate.bind(this.todoView),
                });
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

    submitEventDelegation(evt: Event): void {
        const contentWrap = getParentEl(<HTMLElement>evt.target, '.content-wrap');
        if (!contentWrap) return;
        switch (contentWrap.dataset.type) {
            case 'form':
                onClickSubmit({
                    event: evt,
                    parentClassName: '.todo-columns',
                    type: 'post',
                    cardCallback: this.todoView.addCardUpdate,
                    logCallBack: this.todoView.addLogUpdate.bind(this.todoView),
                });
                break;
            case 'modal-form':
                onClickSubmit({
                    event: evt,
                    parentClassName: '.modal-contents',
                    type: 'patch',
                    cardCallback: this.todoView.modifyCardUpdate.bind(this.todoView),
                    logCallBack: this.todoView.addLogUpdate.bind(this.todoView),
                });
                break;
            default:
                break;
        }
    }
}

export default TodoEventManager;
