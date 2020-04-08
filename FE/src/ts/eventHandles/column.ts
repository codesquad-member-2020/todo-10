function columnClickHandle(target) {
    if (!target.classList.contains('toggle-form')) return;
    target.closest('.content-wrap').querySelector('.todo-form').classList.toggle('active');
}

export {
    columnClickHandle,
}