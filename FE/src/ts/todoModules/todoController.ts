import { getEl, removeClass } from '../utils/commonUtil';
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
    async runTodoApp(data): void {
        const { status } = await httpRequest.login(URL.DEV.LOGIN_API());
        if (status !== STATUS_KEY.SUCCESS) return;

        httpRequest.get(URL.DEV.BOARD_API(), data).then(todoData => {
            removeClass(getEl('#dimmed'), COMMON_RULE.ACTIVE_KEY);
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
