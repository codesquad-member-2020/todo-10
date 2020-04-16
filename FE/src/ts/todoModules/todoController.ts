import { httpRequest } from '../utils/httpRequestUtil';
import { COMMON_RULE } from '../contants/constant';
import { getEl, addClass, removeClass } from '../utils/commonUtil';
import { URL } from '../contants/url';
import TodoView from './todoView';
import TodoEventManager from './todoEventManager';

class TodoController {
    private todoView: TodoView;
    private todoEventManager: TodoEventManager;

    constructor(todoView: TodoView, todoEventManager: TodoEventManager) {
        this.todoView = todoView;
        this.todoEventManager = todoEventManager;
    }

    runTodoApp(): void {
        httpRequest.get(URL.DEV.BOARD_API()).then(todoData => {
            removeClass(getEl('#dimmed'), COMMON_RULE.ACTIVE_KEY);
            addClass(getEl('#logout'), COMMON_RULE.ACTIVE_KEY);
            this.todoView.renderTodoApp(todoData);
            this.todoView.renderTodoModal();
        });

        httpRequest.get(URL.DEV.LOGS_API()).then(logsData => {
            this.todoView.renderTodoMenu(logsData);
        });

        this.todoEventManager.initTodoEvent();
    }
}

export default TodoController;
