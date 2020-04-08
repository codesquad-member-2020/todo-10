class TodoController {
    constructor(module) {
        this.todoView = module.todoView;
        this.todoModel = module.todoModel;
        this.todoEventManager = module.todoEventManager;
    }

    async runTodoApp() {
        await this.todoModel.getTodoData();
        this.todoView.render(this.todoModel.todoData);
        this.todoEventManager.init();
    }
}

export default TodoController;