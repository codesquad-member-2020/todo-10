package com.codesquad.team10.todo.bean;

public class ResponseData {

    public enum Status { SUCCESS, ERROR };

    private Status status;
    private Object content;

    public ResponseData(Status status, Object content) {
        this.status = status;
        this.content = content;
    }

    public String getStatus() {
        return status.name();
    }

    public Object getContent() {
        return content;
    }
}
