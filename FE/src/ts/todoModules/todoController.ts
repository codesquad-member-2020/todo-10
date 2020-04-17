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

        getEl('#add').addEventListener('click', this.addSection);
    }

    addSection() {
        const url = 'http://ec2-15-164-63-83.ap-northeast-2.compute.amazonaws.com:8080/board/section';
        const data = { title: '테스트' };
        const token = sessionStorage.getItem('TODO-TOKEN');
        const option = {
            method: 'POST',
            mode: 'cors',
            body: JSON.stringify(data),
            headers: {
                'Content-Type': 'application/json',
                'Authorization': token
            }
        }
        fetch(url, option);
    }
}

export default TodoController;
