package com.codesquad.team10.todo.exception.custom;

import com.codesquad.team10.todo.constants.ExceptionMessage;

public class UnmatchedRequestDataException extends RuntimeException {

    public UnmatchedRequestDataException() {
        super(ExceptionMessage.UNMATCHED_REQUEST_DATA.getMessage());
    }
}
