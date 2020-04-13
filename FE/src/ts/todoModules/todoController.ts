import { httpRequest } from '../utils/httpRequestUtil';
import { URL } from '../contants/url';
import TodoView from './todoView';
import TodoEventManager from './todoEventManager';

class TodoController {
    private todoView: TodoView;
    private todoEventManager: TodoEventManager;
    
    constructor( todoView:TodoView, todoEventManager:TodoEventManager ) {
        this.todoView = todoView;
        this.todoEventManager = todoEventManager;
    }

    runTodoApp(): void {
        const url = `${URL.MOCKUP.BASE}/mock/login`;
        httpRequest.login(url).then(todoData => {
            this.todoView.todoAppRender(todoData);
            this.todoView.todoModalRender();
            this.todoEventManager.todoAppEventInit();
            this.todoEventManager.todoModalEventInit();
        });
    }
}

export default TodoController;