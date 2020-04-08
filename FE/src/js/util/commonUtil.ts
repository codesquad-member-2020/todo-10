function getElement(target: string) {
    return document.querySelector(target);
}
function getElements(target: string) {
    return document.querySelectorAll(target);
}
function addClass(target: HTMLElement, className: string) {
    target.classList.add(className);
}
function removeClass(target: HTMLElement, className: string) {
    target.classList.remove(className);
}
function clearTransition(target: HTMLElement) {
    target.style.transition = '0s step-start';
}
const getData = async (url: string) => {
    const response = await fetch(url);
    const resPromise = await response.json();
    return resPromise;
};

export { getElement, getElements, addClass, removeClass, clearTransition, getData };
