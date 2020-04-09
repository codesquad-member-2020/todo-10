import { getEl, getParentEl, addClass, removeClass } from '../util/commonUtil.js';

const option = {
    dragTarget: null,
    dummyTarget: null,
    toTarget: null,
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
    const modal = getEl('#modal');
    const content = card.querySelector('.card-contents').innerText;
    modal.querySelector('.todo-textarea').innerText = content;
    addClass(modal, 'active');
}

function dragStartCard(evt) {
    resetOption();
    if (evt.target.dataset.type !== 'card') return;
    option.dragTarget = evt.target;
    option.dummyTarget = option.dragTarget;
    option.prevColumn = getParentEl(option.dragTarget, '.todo-columns');
    addClass(option.dragTarget, 'draging');
}

function dragoverCard(evt) {
    evt.preventDefault();
}

function dragenterCard(evt) {
    option.toTarget = getParentEl(evt.toElement, '.card-item');
    option.currColumn = getParentEl(evt.toElement, '.todo-columns');
    console.log(option.toTarget);
    if (option.toTarget) option.toTarget.after(option.dummyTarget);
    else if (option.currColumn) option.currColumn.querySelector('.card-wrap').appendChild(option.dummyTarget);
}

function dropCard(evt) {
    removeClass(option.dragTarget, 'draging');
    if (!option.dragTarget || !option.currColumn) return;
    let cardWrap = evt.target;
    if (!cardWrap.classList.contains('card-wrap')) cardWrap = option.currColumn.querySelector('.card-wrap');
    if (!option.toTarget) cardWrap.appendChild(option.dragTarget);
    else option.toTarget.after(option.dragTarget);
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
    dragenterCard,
    dropCard,
}