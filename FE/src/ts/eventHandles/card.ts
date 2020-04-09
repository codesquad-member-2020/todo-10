import { getEl, getParentEl, addClass, removeClass } from '../util/commonUtil.js';

const option = {
    dragTarget: null,
    targetHeight: null,
    toTarget: null,
    toTargetWrap: null,
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
    const content = card.querySelector('.card-contents').innerText;
    const modalContents = getEl('.modal-contents');
    modalContents.setAttribute('data-column-id', getParentEl(card, '.todo-columns').dataset.columnId);
    modalContents.setAttribute('data-card-id', card.dataset.cardId);
    modalContents.querySelector('.todo-textarea').value = content;
    addClass(getEl('#modal'), 'active');
}

function dragStartCard({ target }) {
    resetOption();
    if (target.dataset.type !== 'card') return;
    option.dragTarget = target;
    option.targetHeight = target.offsetHeight;
    option.prevColumn = getParentEl(option.dragTarget, '.todo-columns');
    addClass(option.dragTarget, 'draging');
}

function dragoverCard(evt) {
    evt.preventDefault();
}

function dragenterCard(evt) {
    option.toTarget = getParentEl(evt.toElement, '.card-item');
    option.toTargetWrap = getParentEl(evt.toElement, '.card-wrap');
    option.currColumn = getParentEl(evt.toElement, '.todo-columns');
    const cardHeightHalf = option.targetHeight / 2;
    if (option.toTarget && evt.offsetY > cardHeightHalf) option.toTarget.after(option.dragTarget);
    else if (option.toTarget && evt.offsetY <= cardHeightHalf) option.toTarget.before(option.dragTarget);
    else if (option.toTargetWrap) return;
    else if (option.currColumn) option.currColumn.querySelector('.card-wrap').appendChild(option.dragTarget);
}

function dragendCard({ target }) {
    removeClass(option.dragTarget, 'draging');
    if (!option.dragTarget || !option.currColumn) return;
    if (!target.classList.contains('card-wrap')) target = option.currColumn.querySelector('.card-wrap');
    option.prevColumn.querySelector('.todo-count').innerHTML--;
    option.currColumn.querySelector('.todo-count').innerHTML++;

    let order = 0;
    const currColumnId = option.currColumn.dataset.columnId;
    const cardId = option.dragTarget.dataset.cardId;
    [...getParentEl(option.dragTarget, '.card-wrap').children].some(v => {
        order++;
        return option.dragTarget === v;
    });
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
    dragendCard,
}