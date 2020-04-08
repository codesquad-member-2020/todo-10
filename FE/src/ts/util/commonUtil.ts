function getEl(target: string) {
    return document.querySelector(target);
}

function getEls(target: string) {
    return document.querySelectorAll(target);
}

function getParentEl(el: HTMLElement, target: string) {
    return el.closest(target);
}

function addClass(target: HTMLElement, className: string) {
    target.classList.add(className);
}

function removeClass(target: HTMLElement, className: string) {
    target.classList.remove(className);
}

export { getEl, getEls, getParentEl, addClass, removeClass };
