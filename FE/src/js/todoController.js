class TodoController {
    constructor(module) {
        this.todoView = module.todoView;
        this.todoModel = module.todoModel;
        this.todoEventManager = module.todoEventManager;
    }
    async todoInit() {
        await this.todoModel.getTodoData();
        this.todoView.render(this.todoModel.todoData);
        this.todoEventManager.init();
    }
}
export default TodoController;
