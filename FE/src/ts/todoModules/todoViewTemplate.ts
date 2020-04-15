interface ITodoViewTemplate {
    id: string;
    title: string;
    content: string;
    cards: [];
    sections: [];
}

function makeColumns({ sections }: ITodoViewTemplate): string {
    return sections.reduce((acc: string, column: ITodoViewTemplate) => {
        acc +=
            `<div class="todo-columns content-wrap" data-type="column" id="column-${column.id}" data-column-id=${column.id} tabindex="0">
            <div class="todo-title">
            <h2><span class="todo-count">${column.cards.length}</span> ${column.title}</h2>
            <div class="btn-wrap">
                <button class="btn btn-toggle toggle-form"><span class="material-icons">add</span></button>
                <button class="btn"><span class="material-icons">more_vert</span></button>
            </div>
            </div>
            <div class="todo-form content-wrap" data-type="form">
                <form action="">
                    <input type="text" class="todo-input" placeholder="enter a note">
                    <textarea name="" id="" class="todo-textarea" cols="30" rows="10" maxlength="500" placeholder="enter a note"></textarea>
                    <div class="btn-wrap">
                        <button type="submit" class="btn btn-add" disabled="true">add</button>
                        <button type="reset" class="btn btn-close">cancel</button>
                    </div>
                </form>
            </div>
            <div class="card-wrap">
            ${makeCards(column.cards)}
            </div>
        </div>`;
        return acc;
    }, '');
}

function makeCards(cards: []): string {
    return cards.reduce((acc: string, card: ITodoViewTemplate) => {
        acc += addCard(card.id, card.content);
        return acc;
    }, '');
}

function addCard(id: string, content: string): string {
    return `<div class="card-item content-wrap" draggable="true" data-type="card" id="card-${id}" data-card-id="${id}" tabindex="0">
                <div class="card-contents">${content}</div>
                <p class="card-writer">added by <span>홍길동</span></p>
                <button class="btn btn-close">
                    <span class="material-icons">close</span>
                </button>
            </div>`;
}

function makeModal(): string {
    return `<div class="modal-wrap content-wrap" data-type="modal-form">
                <div class="modal-title">
                    <h2>Edit Note</h2>
                    <div class="btn-wrap">
                        <button class="btn btn-close"><span class="material-icons">close</span></button>
                    </div>
                </div>
                <div class="modal-contents">
                    <p>Note</p>
                    <form action="">
                        <input type="text" class="todo-input" placeholder="enter a note">
                        <textarea name="" id="" class="todo-textarea" cols="30" rows="10" maxlength="500" placeholder="enter a note"></textarea>
                        <div class="btn-wrap">
                            <button class="btn btn-add" disabled="true">Save note</button>
                        </div>
                    </form>
                </div>
            </div>`
}

function makeMenu(): string {
    return `<div class="menu-header">
                <h2>☰ menu</h2>
                <div class="btn-wrap">
                    <button class="btn btn-close"><span class="material-icons">close</span></button>
                </div>
            </div>
            <div class="menu-container">
                <div class="menu-title"><span class="material-icons">notifications_active</span>Activity</div>
                <div class="activity-log">
                    <div class="log">
                        <p class="log-msg"><span class="user">@User생략가능</span>액션상태<strong>할일제목</strong></p>
                        <p class="log-time">3 hours ago</p>
                    </div>
                    <div class="log">
                        <p class="log-msg"><span class="user">@User</span>add<strong>할일제목</strong>to<strong>특정액션</strong></p>
                        <p class="log-time">3 hours ago</p>
                    </div>
                    <div class="log">
                        <p class="log-msg"><span class="user">@User</span>moved<strong>할일제목</strong>from<strong>특정액션</strong></p>
                        <p class="log-time">3 hours ago</p>
                    </div>
                    <div class="log">
                        <p class="log-msg"><span class="user">@User</span>remove<strong>할일제목</strong></strong></p>
                        <p class="log-time">3 hours ago</p>
                    </div>
                    <div class="log">
                        <p class="log-msg"><span class="user">@User</span>update<strong>할일제목</strong></strong></p>
                        <p class="log-time">3 hours ago</p>
                    </div>
                </div>
            </div>`
}

export {
    makeColumns,
    addCard,
    makeModal,
    makeMenu,
}