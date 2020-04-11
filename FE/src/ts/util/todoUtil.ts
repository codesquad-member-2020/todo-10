interface ICheckDisabled {
    target: EventTarget | HTMLElement | any;
}

function checkDisabled({ target }: ICheckDisabled): boolean {
    const contentWrap = <HTMLElement>target.closest('.content-wrap');
    const btn = <HTMLButtonElement>contentWrap.querySelector('.btn-add');
    return isEmpty(target.value) ? (btn.disabled = true) : (btn.disabled = false);
}

function isEmpty(property: string): boolean {
    return property === null || property === '' || typeof property === 'undefined';
}

export {
    checkDisabled,
}