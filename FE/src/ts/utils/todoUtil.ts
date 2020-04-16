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

function timeSince(date) {
    const seconds = Math.floor((new Date() - date) / 1000);
    let interval = Math.floor(seconds / 31536000);
    if (interval > 1) return interval + "년";
    interval = Math.floor(seconds / 2592000);
    if (interval > 1) return interval + "달";
    interval = Math.floor(seconds / 86400);
    if (interval > 1) return interval + "일";
    interval = Math.floor(seconds / 3600);
    if (interval > 1) return interval + "시간";
    interval = Math.floor(seconds / 60);
    if (interval > 1) return interval + "분";
    return Math.floor(seconds) + "방금";
}

export {
    checkDisabled,
    timeSince,
}