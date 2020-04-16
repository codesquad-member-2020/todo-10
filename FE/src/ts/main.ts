import { getEl } from './utils/commonUtil';
import { checkUser, loginInit } from './loginModule/login';
import TodoController from './todoModules/todoController';
import TodoView from './todoModules/todoView';
import TodoEventManager from './todoModules/todoEventManager';

const todoView = new TodoView();
const todoEventManager = new TodoEventManager(todoView);
const todoController = new TodoController(todoView, todoEventManager);

loginInit();

getEl('#dimmed').querySelector('.btn').addEventListener('click', (e) => {
    e.preventDefault();
    const loginIdEl = <HTMLInputElement>getEl('#userID');
    const loginPwEl = <HTMLInputElement>getEl('#password');
    const data = {
        name: loginIdEl.value,
        password: loginPwEl.value,
    };
    return checkUser(data, todoController.runTodoApp);
});
