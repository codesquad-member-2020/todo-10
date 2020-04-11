function getEl(target: string) {
    return document.querySelector(target);
}

function getEls(target: string) {
    return document.querySelectorAll(target);
}

function getParentEl(el: HTMLElement, target: string) {
    return el.closest(target);
}

function getClosestEl(el: HTMLElement, closestTarget: string, target: string) {
    return el.closest(closestTarget)?.querySelector(target);
}

function addClass(target: HTMLElement, className: string) {
    target.classList.add(className);
}

function removeClass(target: HTMLElement, className: string) {
    target.classList.remove(className);
}

function toggleClass({ target, closestClass, containsClassName, toggleClassName }) {
    if (!target.classList.contains(containsClassName)) return;
    target.closest(closestClass).classList.toggle(toggleClassName);
}

export { getEl, getEls, getParentEl, getClosestEl, addClass, removeClass, toggleClass };
