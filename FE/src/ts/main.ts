import TodoController from './todoController.js';
import TodoView from './todoView.js';
import TodoEventManager from './todoEventManager.js';

const todoView = new TodoView();
const todoEventManager = new TodoEventManager({ todoView });
const todoController = new TodoController({ todoView, todoEventManager });

todoController.runTodoApp();