package com.codesquad.team10.todo.constants;

public enum ExceptionMessage {

    RESOURCE_NOT_FOUND("리소스를 찾을 수 없습니다."),
    USER_NOT_FOUND("존재하지 않는 사용자입니다."),
    UNMATCHED_DATA("서버 데이터와 일치하지 않습니다.");

    private String message;

    private ExceptionMessage(String message) {
        this.message = message;
    }

    public String getMessage() {
        return message;
    }
}
