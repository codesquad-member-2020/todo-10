package com.codesquad.team10.todo.exception.custom;

import com.codesquad.team10.todo.constants.ExceptionMessage;

public class ResourceNotFoundException extends RuntimeException {

    public ResourceNotFoundException() {
        super(ExceptionMessage.RESOURCE_NOT_FOUND.getMessage());
    }
}
