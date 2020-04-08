import { getParentEl, getEl, addClass } from '../util/commonUtil.js';

const option = {
    dragTarget: null,
    prevColumn: null,
    currColumn: null,
}

async function cardClickHandle(target, deleteCardRequest) {
    if (!target.classList.contains('btn-close')) return;
    if (!confirm('선택하신 카드를 삭제 하시겠습니까?')) return;
    const { status } = await deleteCardRequest(1, 1);
    if (status !== 'SUCCESS') return;
    getParentEl(target, '.todo-columns').querySelector('.todo-count').innerHTML--;
    getParentEl(target, '.card-item').remove();
}

function cardDblclickHandle({ target }) {
    const card = getParentEl(target, '.card-item');
    if (!card) return;
    addClass(getEl('#modal'), 'active');
}

function cardDragStartHandle(evt) {
    resetOption();
    if (evt.target.dataset.type !== 'card') return;
    option.dragTarget = evt.target;
    option.prevColumn = getParentEl(option.dragTarget, '.todo-columns');
}

function cardDragover(evt) {
    evt.preventDefault();
}

function cardDrop(evt) {
    if (!option.dragTarget) return;
    let cardWrap = evt.target;
    option.currColumn = getParentEl(cardWrap, '.todo-columns');
    if (!cardWrap.classList.contains('card-wrap')) cardWrap = option.currColumn.querySelector('.card-wrap');
    cardWrap.appendChild(option.dragTarget);
    option.prevColumn.querySelector('.todo-count').innerHTML--;
    option.currColumn.querySelector('.todo-count').innerHTML++;
}

function resetOption() {
    option.dragTarget = null;
    option.prevColumn = null;
    option.currColumn = null;
}

export {
    cardClickHandle,
    cardDblclickHandle,
    cardDragStartHandle,
    cardDragover,
    cardDrop,
}