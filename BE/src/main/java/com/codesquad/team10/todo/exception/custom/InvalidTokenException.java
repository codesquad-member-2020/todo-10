package com.codesquad.team10.todo.exception.custom;

import com.codesquad.team10.todo.constants.ExceptionMessage;

public class InvalidTokenException extends RuntimeException {

    public InvalidTokenException() {
        super(ExceptionMessage.INVALID_TOKEN.getMessage());
    }
}
