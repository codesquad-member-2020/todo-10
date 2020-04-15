package com.codesquad.team10.todo.exception.custom;

import com.codesquad.team10.todo.constants.ExceptionMessage;

public class UnauthorizedException extends RuntimeException {

    public UnauthorizedException() {
        super(ExceptionMessage.LOGIN_FAILED.getMessage());
    }
}
