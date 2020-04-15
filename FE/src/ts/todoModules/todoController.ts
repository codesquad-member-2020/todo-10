import { httpRequest } from '../utils/httpRequestUtil';
import { COMMON_RULE, STATUS_KEY } from '../contants/constant';
import { getEl, removeClass } from '../utils/commonUtil';
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

    async runTodoApp(): void {
        const loginUrl = URL.DEV.LOGIN_API();
        const { status } = await httpRequest.login(loginUrl);
        if (status !== STATUS_KEY.SUCCESS) return;

        const boardUrl = URL.DEV.BOARD_API();
        httpRequest.get(boardUrl).then(todoData => {
            removeClass(getEl('.loading-wrap'), COMMON_RULE.ACTIVE_KEY);
            this.todoView.renderTodoApp(todoData);
            this.todoView.renderTodoModal();
        });
        const logsUrl = URL.DEV.LOGS_API();
        httpRequest.get(logsUrl).then(logsData => {
            this.todoView.renderTodoMenu(logsData);
        });
        this.todoEventManager.initTodoEvent();
    }
}

export default TodoController;