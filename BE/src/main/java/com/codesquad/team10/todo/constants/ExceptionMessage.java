package com.codesquad.team10.todo.constants;

public enum ExceptionMessage {

    RESOURCE_NOT_FOUND("리소스를 찾을 수 없습니다."),
    USER_NOT_FOUND("존재하지 않는 사용자입니다."),
    FORBIDDEN("접근 권한이 없습니다."),
    INVALID_REQUEST("요청 데이터가 충족하지 않습니다."),
    UNMATCHED_REQUEST_DATA("요청 데이터가 서버와 일치하지 않습니다.");

    private String message;

    private ExceptionMessage(String message) {
        this.message = message;
    }

    public String getMessage() {
        return message;
    }
}
