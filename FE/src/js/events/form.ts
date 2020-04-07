function formClickHandle(target) {
    if (!target.classList.contains('btn-close')) return;
    target.closest('.todo-form').classList.toggle('active');
}

function formSubmitHandle(evt, fetchCallBack) {
    evt.preventDefault();
    // 서버 통신
    // fetchCallBack();
}

export {
    formClickHandle,
    formSubmitHandle,
}