import { getParentEl } from '../util/commonUtil.js';

const option = {
    dragTarget: null,
    prevColumn: null,
    currColumn: null,
}

function cardClickHandle(target) {
    if (!target.classList.contains('btn-close')) return;
    if (!confirm('선택하신 카드를 삭제 하시겠습니까?')) return;
    // 카드 삭제
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
    cardDragStartHandle,
    cardDragover,
    cardDrop,
}