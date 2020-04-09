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
function isEmpty(property) {
    return (property === null || property === "" || typeof property === "undefined");
}
export { getEl, getEls, getParentEl, addClass, removeClass, isEmpty };
