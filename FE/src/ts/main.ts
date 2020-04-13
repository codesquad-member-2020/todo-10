import TodoController from './todoModules/todoController';
import TodoView from './todoModules/todoView';
import TodoEventManager from './todoModules/todoEventManager';

const todoView = new TodoView();
const todoEventManager = new TodoEventManager({ todoView });
const todoController = new TodoController(todoView, todoEventManager);

todoController.runTodoApp();
