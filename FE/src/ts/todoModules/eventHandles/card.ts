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

async function deleteCard(target: HTMLElement) {
    if (!target.classList.contains('btn-close')) return;
    if (!confirm(ALERT_MESSAGE.DELETE_CARD)) return;
    const column: HTMLElement = getParentEl(target, '.todo-columns');
    const card: HTMLElement = getParentEl(target, '.card-item');
    const columnId = column.dataset.columnId;
    const cardId = card.dataset.cardId;
    const url = URL.DEV.UPDATE_CARD_API(columnId, cardId);
    const { status, content } = await httpRequest.delete(url);

    if (status !== STATUS_KEY.SUCCESS) return;
    let count = column.querySelector('.todo-count');
    count.innerHTML = content.card_count;
    card.remove();
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

function dragendCard({ target }: Event) {
    if (!option.dragTarget) return;
    removeClass(option.dragTarget, COMMON_RULE.DRAG_KEY);
    if (!option.dragTarget || !option.currColumn) return;
    if (!target.classList.contains('card-wrap')) target = option.currColumn.querySelector('.card-wrap');
    option.prevColumn.querySelector('.todo-count').innerHTML--;
    option.currColumn.querySelector('.todo-count').innerHTML++;
}

function getDragedCardInfo() {
    let order = 0;
    const currColumnId = option.currColumn.dataset.columnId;
    const cardId = option.dragTarget.dataset.cardId;
    [...getParentEl(option.dragTarget, '.card-wrap').children].some(v => {
        order++;
        return option.dragTarget === v;
    });
    order--;
    return { cardId, order, currColumnId };
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