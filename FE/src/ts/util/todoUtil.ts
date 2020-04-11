function checkDisabled({ target }) {
    const contentWrap = target.closest('.content-wrap');
    const btn = contentWrap.querySelector('.btn-add');
    return isEmpty(target.value) ? (btn.disabled = true) : (btn.disabled = false);
}

function isEmpty(property: string) {
    return property === null || property === '' || typeof property === 'undefined';
}

export {
    checkDisabled,
}