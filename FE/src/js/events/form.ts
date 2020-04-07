function formClickHandle(target) {
    if (!target.classList.contains('btn-close')) return;
    target.closest('.todo-form').classList.toggle('active');
}

function formSubmitHandle(evt, fetchCallBack) {
    evt.preventDefault();
    // 서버 통신
    // fetchCallBack();
    addCardTempFunc(evt);
}

function addCardTempFunc(evt) {
    const content = evt.target.querySelector('textarea').value;
    evt.target.closest('.todo-columns').querySelector('.card-wrap').innerHTML +=
        `<div class="card-item content-wrap" data-type="card" data-card-id="" tabindex="0">
            <div class="card-contents">${content}</div>
            <p class="card-writer">added by <span>홍길동</span></p>
            <button class="btn btn-close">
            <span class="material-icons">close</span>
            </button>
        </div>`
    evt.target.closest('.todo-columns').querySelector('.todo-count').innerHTML++;
    evt.target.reset();
    evt.target.closest('.todo-form').classList.toggle('active');
}

export {
    formClickHandle,
    formSubmitHandle,
}