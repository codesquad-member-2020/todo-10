import { httpRequest } from '../utils/httpRequestUtil';
import { URL } from '../contants/url';
import TodoView from './todoView';
import TodoEventManager from './todoEventManager';

import { logData } from '../../_data/logDummyData';

class TodoController {
    private todoView: TodoView;
    private todoEventManager: TodoEventManager;

    constructor(todoView: TodoView, todoEventManager: TodoEventManager) {
        this.todoView = todoView;
        this.todoEventManager = todoEventManager;
    }

    runTodoApp(): void {
        this.todoEventManager.initTodoHeaderEvent();

        const url = URL.DEV.LOGIN_API();
        httpRequest.login(url).then(todoData => {
            this.todoView.renderTodoApp(todoData);
            this.todoView.renderTodoModal();
            this.todoEventManager.initTodoAppEvent();
            this.todoEventManager.initTodoModalEvent();
        });

        this.todoView.renderTodoMenu(logData);
        this.todoEventManager.initTodoMenuEvent();
    }
}

export default TodoController;