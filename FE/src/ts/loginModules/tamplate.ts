const drawLoading = () => {
    return `<div class="loading">
                <div></div>
                <div></div>
                <div></div>
            </div>`;
};

const drawLoginForm = () => {
    return `<div class="login-box">
    <div class="login-title">TODO 서비스</div>
    <p>#TEAM10 - TODO LOGIN <span>현재는 임시 회원만 사용 가능합니다.</span></p>
    <div class="row">
        <span class="input-box"><input type="text" id="userID" name="userID" placeholder="아이디 입력" /></span>
    </div>
    <div class="row">
        <span class="input-box"><input type="password" id="password" name="password"
                placeholder="비밀번호" /></span>
    </div>
    <button class="btn btn-submit">LOGIN</button>
</div>`;
};

export { drawLoading, drawLoginForm };
