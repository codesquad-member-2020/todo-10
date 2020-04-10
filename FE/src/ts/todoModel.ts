import { URL } from './contants/url.js';

class TodoModel {
    constructor() {
        this.todoData = null;
    }

    getTodoData() {
        return fetch(`${URL.DEV.HOST}/mock/login`,
            {
                method: 'POST',
                mode: 'cors',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    email: "nigayo@ggmail.com",
                    password: "1234"
                })
            })
            .then(res => res.json())
            .then(json => this.todoData = json);
    }

    deleteCardRequest(columnId, cardId) {
        return fetch(`${URL.DEV.HOST}/mock/section/${columnId}/card/${cardId}`,
            {
                mode: 'cors',
                method: 'DELETE'
            })
            .then(res => res.json());
    }
}

export default TodoModel;
