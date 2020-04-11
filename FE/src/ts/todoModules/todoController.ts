import { httpRequest } from '../http/request';
import { URL } from '../contants/url';

class TodoController {
    constructor(module) {
        this.todoView = module.todoView;
        this.todoEventManager = module.todoEventManager;
    }

    async runTodoApp() {
        const url = `${URL.DEV.HOST}/mock/login`;
        httpRequest.login(url).then(todoData => {
            this.todoView.todoAppRender(todoData);
            this.todoEventManager.init();
        });
    }
}

export default TodoController;