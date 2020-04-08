import data from './_data/mockdata.js';

class TodoModel {
    constructor() {
        // this.todoData = null;
        this.todoData = data;
    }

    getTodoData() {
        // return fetch('https://cors-anywhere.herokuapp.com/http://ec2-15-164-63-83.ap-northeast-2.compute.amazonaws.com:8080/mock/login', {
        //     method: 'POST',
        //     mode: 'cors',
        //     headers: { 'Content-Type': 'application/json' },
        //     body: JSON.stringify({
        //         email: "nigayo@ggmail.com",
        //         password: "1234"
        //     })
        // })
        //     .then(res => res.json())
        //     .then(json => this.todoData = json);
    }

    deleteCardRequest(columnId, cardId) {
        return fetch(`https://cors-anywhere.herokuapp.com/http://ec2-15-164-63-83.ap-northeast-2.compute.amazonaws.com:8080/mock/section/${columnId}/card/${cardId}`, { method: 'DELETE' })
            .then(res => res.json())
    }
}

export default TodoModel;
