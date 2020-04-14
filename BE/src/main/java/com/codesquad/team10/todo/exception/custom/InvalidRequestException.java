package com.codesquad.team10.todo.exception.custom;

import com.codesquad.team10.todo.constants.ExceptionMessage;

public class InvalidRequestException extends RuntimeException {

    public InvalidRequestException() {
        super(ExceptionMessage.BAD_REQUEST.getMessage());
    }
}
