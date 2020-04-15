package com.codesquad.team10.todo.exception.custom;

import com.codesquad.team10.todo.constants.ExceptionMessage;

public class ForbiddenException extends RuntimeException {

    public ForbiddenException() {
        super(ExceptionMessage.FORBIDDEN.getMessage());
    }
}
