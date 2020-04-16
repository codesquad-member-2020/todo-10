import { timeSince } from '../utils/todoUtil';
import { COMMON_RULE } from '../contants/constant';

interface ITodoViewTemplate {
    id: string;
    title: string;
    content: string;
    cards: [];
    sections: [];
}

function makeColumns(columns: ITodoViewTemplate): string {
    return columns.reduce((acc: string, column: ITodoViewTemplate) => {
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
        acc += addCard(card);
        return acc;
    }, '');
}

function addCard(card): string {
    return `<div class="card-item content-wrap" draggable="true" data-type="card" id="card-${card.id}" data-card-id="${card.id}" tabindex="0">
                <div class="card-contents">${card.content}</div>
                <p class="card-writer">added by <span>${card.author}</span></p>
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
            </div>`;
}

function makeMenu(logs): string {
    return `<div class="menu-header content-wrap" data-type="menu">
                <h2>☰ menu</h2>
                <div class="btn-wrap">
                    <button class="btn btn-close"><span class="material-icons">close</span></button>
                </div>
            </div>
            <div class="menu-container">
                <div class="menu-title"><span class="material-icons">notifications_active</span>Activity</div>
                <div class="activity-log">
                    ${makeLogs(logs)}
                </div>
            </div>`;
}

function makeLogs(logs: []): string {
    const limitLogs = logs.reverse().slice(0, COMMON_RULE.LIMIT_LOG_LENGTH);
    return limitLogs.reduce((acc: string, log: ITodoViewTemplate) => {
        acc += switchLog(log);
        return acc;
    }, '');
}

function switchLog(log): string {
    const action = log.action;
    switch (action) {
        case 'ADDED':
            return makeAddActionLog(log);
            break;
        case 'UPDATED':
            return makeUpdateActionLog(log);
            break;
        case 'REMOVED':
            return makeDeleteActionLog(log);
            break;
        case 'MOVED':
            return makeMoveActionLog(log);
            break;
    }
}

function makeAddActionLog(log) {
    return `<div class="log">
                <p class="log-msg"><span class="user"><strong>@${log.user}</strong></span>added<strong>${log.content}</strong>to<strong>${log.destination}</strong></p>
                <p class="log-time" data-time="${log.createDateTime}">${timeSince(new Date(log.createDateTime))} 전</p>
            </div>`;
}

function makeUpdateActionLog(log) {
    return `<div class="log">
                <p class="log-msg"><span class="user"><strong>@${log.user}</strong></span>updated<strong>${log.content}</strong></p>
                <p class="log-time" data-time="${log.createDateTime}">${timeSince(new Date(log.createDateTime))} 전</p>
            </div>`;
}

function makeDeleteActionLog(log) {
    return `<div class="log">
                <p class="log-msg"><span class="user"><strong>@${log.user}</strong></span>removed<strong>${log.content}</strong>from<strong>${log.source}</strong></p>
                <p class="log-time" data-time="${log.createDateTime}">${timeSince(new Date(log.createDateTime))} 전</p>
            </div>`;
}

function makeMoveActionLog(log) {
    return `<div class="log">
                <p class="log-msg"><span class="user"><strong>@${log.user}</strong></span>moved<strong>${log.content}</strong>from<strong>${log.source}</strong>to<strong>${log.destination}</strong></p>
                <p class="log-time" data-time="${log.createDateTime}">${timeSince(new Date(log.createDateTime))} 전</p>
            </div>`;
}

function injectLog(wrap, log) {
    const logTemp = switchLog(log);
    wrap.insertAdjacentHTML('afterbegin', logTemp);
}

export {
    makeColumns,
    addCard,
    makeModal,
    makeMenu,
    injectLog,
}