import { httpRequest } from '../http/request';
import { URL } from '../contants/url';

class TodoController {
    constructor({ todoView, todoEventManager }) {
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