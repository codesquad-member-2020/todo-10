import Login from './loginModules/login';
import TodoController from './todoModules/todoController';
import TodoView from './todoModules/todoView';
import TodoEventManager from './todoModules/todoEventManager';


const todoView = new TodoView();
const todoEventManager = new TodoEventManager(todoView);
const todoController = new TodoController(todoView, todoEventManager);

const login = new Login(todoController.runTodoApp.bind(todoController));

function main() {
    if (!login.checkToken()) login.loginInit();
    else todoController.runTodoApp();
}
main();