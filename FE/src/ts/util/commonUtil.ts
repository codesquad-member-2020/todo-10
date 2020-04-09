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

function addClass(el: HTMLElement, className: string) {
    el.classList.add(className);
}

function removeClass(el: HTMLElement, className: string) {
    el.classList.remove(className);
}

function isEmpty(property: string) {
    return (property === null || property === "" || typeof property === "undefined");
}

export { getEl, getEls, getParentEl, getClosestEl, addClass, removeClass, isEmpty };
