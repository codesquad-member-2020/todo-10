import { getEl, getParentEl, addClass, removeClass } from '../../utils/commonUtil';
import { ALERT_MESSAGE, COMMON_RULE, STATUS_KEY } from '../../contants/constant';
import { URL } from '../../contants/url';
import { httpRequest } from '../../utils/httpRequestUtil';

interface ICardOption {
    dragTarget: Node | HTMLElement | null;
    targetHeight: number | null;
    toTarget: Node | HTMLElement | null;
    toTargetWrap: Node | HTMLElement | null;
    prevColumn: Node | HTMLElement | null;
    currColumn: Node | HTMLElement | null;
}

const option: ICardOption = {
    dragTarget: null,
    targetHeight: null,
    toTarget: null,
    toTargetWrap: null,
    prevColumn: null,
    currColumn: null,
}

const info = {
    prevColumnId: null,
    currColumnId: null,
    cardId: null,
    order: 0,
}

function deleteCard({ target, logCallBack }) {
    if (!target.classList.contains('btn-close')) return;
    if (!confirm(ALERT_MESSAGE.DELETE_CARD)) return;
    const column: HTMLElement = getParentEl(target, '.todo-columns');
    const card: HTMLElement = getParentEl(target, '.card-item');
    deleteRequest(column, card, logCallBack);
}

async function deleteRequest(column, card, logCallBack) {
    const columnId = column.dataset.columnId;
    const cardId = card.dataset.cardId;
    const { status, content } = await httpRequest.delete(URL.DEV.UPDATE_CARD_API(columnId, cardId));

    if (status !== STATUS_KEY.SUCCESS) return;
    column.querySelector('.todo-count').innerHTML = content.card_count;
    card.remove();
    httpRequest.get(URL.DEV.LOG_API(content.log_id)).then((data) => logCallBack(data));
}

function showEditModal({ target }: Event) {
    const card = getParentEl(<HTMLElement>target, '.card-item');
    if (!card) return;
    const content = card.querySelector('.card-contents')!.innerHTML;
    const modalContents = getEl('.modal-contents');

    modalContents.setAttribute('data-column-id', getParentEl(card, '.todo-columns').dataset.columnId!);
    modalContents.setAttribute('data-card-id', card.dataset.cardId!);
    modalContents.querySelector<HTMLTextAreaElement>('.todo-textarea')!.value = content;
    addClass(this.todoView.todoModal, COMMON_RULE.ACTIVE_KEY);
}

function dragStartCard({ target }: Event) {
    resetOption();
    if ((<HTMLElement>target).dataset.type !== 'card') return;
    option.dragTarget = <HTMLElement>target;
    option.targetHeight = target.offsetHeight;
    option.prevColumn = getParentEl(<HTMLElement>option.dragTarget, '.todo-columns');
    addClass(<HTMLElement>option.dragTarget, COMMON_RULE.DRAG_KEY);
}

function dragoverCard(evt) {
    evt.preventDefault();
}

function dragenterCard(evt: Event) {
    if (!option.dragTarget) return;
    option.toTarget = getParentEl(evt.toElement, '.card-item');
    option.toTargetWrap = getParentEl(evt.toElement, '.card-wrap');
    option.currColumn = getParentEl(evt.toElement, '.todo-columns');
    const cardHeightHalf = option.targetHeight / 2;

    if (option.toTarget && evt.offsetY > cardHeightHalf) option.toTarget.after(option.dragTarget);
    else if (option.toTarget && evt.offsetY <= cardHeightHalf) option.toTarget.before(option.dragTarget);
    else if (option.toTargetWrap) return;
    else if (option.currColumn) option.currColumn.querySelector('.card-wrap').appendChild(option.dragTarget);
}

function dragendCard(logCallBack, { target }: Event) {
    if (!option.dragTarget) return;
    removeClass(option.dragTarget, COMMON_RULE.DRAG_KEY);
    if (!option.dragTarget || !option.currColumn) return;
    if (!target.classList.contains('card-wrap')) target = option.currColumn.querySelector('.card-wrap');
    moveRequest(logCallBack);
}

function getDragedCardInfo() {
    info.order = 0;
    info.prevColumnId = option.prevColumn.dataset.columnId;
    info.currColumnId = option.currColumn.dataset.columnId;
    info.cardId = option.dragTarget.dataset.cardId;
    [...getParentEl(option.dragTarget, '.card-wrap').children].some(card => {
        info.order++;
        return option.dragTarget === card;
    });
    info.order--;
}

async function moveRequest(logCallBack) {
    getDragedCardInfo();
    let data;
    const { prevColumnId, currColumnId, cardId, order } = info;
    if (prevColumnId === currColumnId) {
        data = await httpRequest.put(URL.DEV.MOVE_CARD_API(prevColumnId, cardId, order))
    } else {
        data = await httpRequest.put(URL.DEV.COLUMN_MOVE_CARD_API(prevColumnId, cardId, order, currColumnId))
    }

    const { log_id, card_count_to_section, card_count_from_section } = data.content;
    if (card_count_from_section === undefined) return;
    option.currColumn.querySelector('.todo-count').innerHTML = card_count_to_section;
    option.prevColumn.querySelector('.todo-count').innerHTML = card_count_from_section;
    httpRequest.get(URL.DEV.LOG_API(log_id)).then((data) => logCallBack(data));
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