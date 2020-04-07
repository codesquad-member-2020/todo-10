import TodoController from './todoController.js';
import TodoView from './todoView.js';
import TodoModel from './todoModel.js';
import TodoEventManager from './todoEventManager.js';

const todoView = new TodoView();
const todoModel = new TodoModel();
const todoEventManager = new TodoEventManager({ todoView });
const todoController = new TodoController({ todoView, todoModel, todoEventManager });

todoController.todoInit();