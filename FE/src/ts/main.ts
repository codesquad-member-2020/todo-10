import Login from './loginModules/login';
import TodoController from './todoModules/todoController';
import TodoView from './todoModules/todoView';
import TodoEventManager from './todoModules/todoEventManager';

const token = sessionStorage.getItem('TODO-TOKEN');

const todoView = new TodoView();
const todoEventManager = new TodoEventManager(todoView);
const todoController = new TodoController(todoView, todoEventManager);

const login = new Login(todoController);

function main() {
    if (!token) {
        login.loginInit();
        login.loginHandler();
    }
    todoController.runTodoApp();
}
main();