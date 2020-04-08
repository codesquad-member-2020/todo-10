function getEl(target) {
    return document.querySelector(target);
}
function getEls(target) {
    return document.querySelectorAll(target);
}
function getParentEl(el, target) {
    return el.closest(target);
}
function addClass(target, className) {
    target.classList.add(className);
}
function removeClass(target, className) {
    target.classList.remove(className);
}
export { getEl, getEls, getParentEl, addClass, removeClass };
