import { getEl, addClass } from './utils/commonUtil';
import { USER } from './loginModule/data';
import TodoController from './todoModules/todoController';
import TodoView from './todoModules/todoView';
import TodoEventManager from './todoModules/todoEventManager';

const todoView = new TodoView();
const todoEventManager = new TodoEventManager(todoView);
const todoController = new TodoController(todoView, todoEventManager);

const dimmedEl = getEl('#dimmed');
addClass(dimmedEl, 'active');

const drawLoading = () => {
    return `<div class="loading">
                <div></div>
                <div></div>
                <div></div>
            </div>`;
};
const checkUser = (data) => {
    const checkEmail = USER.find((user) => user.email === data.email);
    if (!checkEmail) return alert('회원이 아닙니다.');
    if (checkEmail.password !== data.password) return alert('비밀번호를 확인해주세요.');
    return data;
};

dimmedEl.querySelector('.btn').addEventListener('click', (e) => {
    e.preventDefault();
    const loginIdEl = <HTMLInputElement>getEl('#userID');
    const loginPwEl = <HTMLInputElement>getEl('#password');
    const data = {
        email: loginIdEl.value,
        password: loginPwEl.value,
    };
    const checkEmail = USER.find((user) => user.email === data.email);
    if (!checkEmail) return alert('회원이 아닙니다.');
    if (checkEmail.password !== data.password) return alert('비밀번호를 확인해주세요.');
    dimmedEl.innerHTML = drawLoading();
    todoController.runTodoApp(data);
});
