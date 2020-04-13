package com.codesquad.team10.todo.exception.custom;

import com.codesquad.team10.todo.constants.ExceptionMessage;

public class UserNotFoundException extends RuntimeException {

    public UserNotFoundException() {
        super(ExceptionMessage.USER_NOT_FOUND.getMessage());
    }
}
