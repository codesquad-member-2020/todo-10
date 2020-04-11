import { httpRequest } from './http/request.js';
import { URL } from './contants/url.js';

class TodoController {
    constructor(module) {
        this.todoView = module.todoView;
        this.todoModel = module.todoModel;
        this.todoEventManager = module.todoEventManager;
    }

    async runTodoApp() {
        const url = `${URL.DEV.HOST}/mock/login`;
        httpRequest.login(url).then(todoData => {
            this.todoView.render(todoData);
            this.todoEventManager.init();
        });
    }
}

export default TodoController;