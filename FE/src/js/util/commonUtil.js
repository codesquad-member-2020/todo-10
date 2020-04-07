function getElement(target) {
    return document.querySelector(target);
}
function getElements(target) {
    return document.querySelectorAll(target);
}
function addClass(target, className) {
    target.classList.add(className);
}
function removeClass(target, className) {
    target.classList.remove(className);
}
function clearTransition(target) {
    target.style.transition = '0s step-start';
}
const getData = async (url) => {
    const response = await fetch(url);
    const resPromise = await response.json();
    return resPromise;
};
export { getElement, getElements, addClass, removeClass, clearTransition, getData };
