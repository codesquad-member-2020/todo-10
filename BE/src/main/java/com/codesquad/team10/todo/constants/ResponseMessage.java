package com.codesquad.team10.todo.constants;

public enum ResponseMessage {
    LOGIN_SUCCESS("로그인 성공"),
    LOGIN_FAILED("로그인 실패"),
    CARD_NOT_MOVED("카드 이동 무효");

    private String message;

    private ResponseMessage(String message) {
        this.message = message;
    }

    public String getMessage() {
        return message;
    }
}
