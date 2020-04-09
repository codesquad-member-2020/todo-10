import { getEl, getParentEl, addClass } from '../util/commonUtil.js';

const option = {
    dragTarget: null,
    prevColumn: null,
    currColumn: null,
}

async function deleteCard(target, deleteCardRequest) {
    if (!target.classList.contains('btn-close')) return;
    if (!confirm('선택하신 카드를 삭제 하시겠습니까?')) return;
    const column = getParentEl(target, '.todo-columns');
    const card = getParentEl(target, '.card-item');
    const columnId = column.dataset.columnId;
    const cardId = card.dataset.cardId;
    const { status } = await deleteCardRequest(columnId, cardId);

    if (status !== 'SUCCESS') return;
    column.querySelector('.todo-count').innerHTML--;
    card.remove();
}

function showEditModal({ target }) {
    const card = getParentEl(target, '.card-item');
    if (!card) return;

    addClass(getEl('#modal'), 'active');
}

function dragStartCard(evt) {
    resetOption();
    if (evt.target.dataset.type !== 'card') return;
    option.dragTarget = evt.target;
    option.prevColumn = getParentEl(option.dragTarget, '.todo-columns');
}

function dragoverCard(evt) {
    evt.preventDefault();
}

function dropCard(evt) {
    if (!option.dragTarget) return;
    let cardWrap = evt.target;
    option.currColumn = getParentEl(cardWrap, '.todo-columns');
    if (!cardWrap.classList.contains('card-wrap')) cardWrap = option.currColumn.querySelector('.card-wrap');
    cardWrap.appendChild(option.dragTarget);
    option.prevColumn.querySelector('.todo-count').innerHTML--;
    option.currColumn.querySelector('.todo-count').innerHTML++;
}

function resetOption() {
    for (let key in option) {
        option[key] = null;
    }
}

export {
    deleteCard,
    showEditModal,
    dragStartCard,
    dragoverCard,
    dropCard,
}