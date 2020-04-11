import TodoController from './todoModules/todoController.js';
import TodoView from './todoModules/todoView.js';
import TodoEventManager from './todoModules/todoEventManager.js';

const todoView = new TodoView();
const todoEventManager = new TodoEventManager({ todoView });
const todoController = new TodoController({ todoView, todoEventManager });

todoController.runTodoApp();