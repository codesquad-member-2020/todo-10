interface IToggleClass {
    target: HTMLElement | any;
    closestClass: string;
    containsClassName: string;
    toggleClassName: string;
}

function getEl(target: string): HTMLElement {
    return <HTMLElement>document.querySelector(target);
}

function getEls(target: string) {
    return document.querySelectorAll(target);
}

function getParentEl(el: HTMLElement, target: string): HTMLElement {
    return <HTMLElement>el.closest(target);
}

function getClosestEl(el: HTMLElement, closestTarget: string, target: string): HTMLElement {
    return <HTMLElement>el.closest(closestTarget)?.querySelector(target);
}

function addClass(target: HTMLElement, className: string): void {
    target.classList.add(className);
}

function removeClass(target: HTMLElement, className: string): void {
    target.classList.remove(className);
}

function hasClass(target: HTMLElement, className: string): boolean {
    return target.classList.contains(className);
}

function toggleClass({ target, closestClass, containsClassName, toggleClassName }: IToggleClass): void {
    if (!target.classList.contains(containsClassName)) return;
    target.closest(closestClass).classList.toggle(toggleClassName);
}

export { getEl, getEls, getParentEl, getClosestEl, addClass, removeClass, hasClass, toggleClass };
