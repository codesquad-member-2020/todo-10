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

function isEmpty(property: string) {
    return (property === null || property === "" || typeof property === "undefined");
 }

export { getEl, getEls, getParentEl, addClass, removeClass, isEmpty };
