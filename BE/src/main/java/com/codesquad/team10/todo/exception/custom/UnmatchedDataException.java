package com.codesquad.team10.todo.exception.custom;

import com.codesquad.team10.todo.constants.ExceptionMessage;

public class UnmatchedDataException extends RuntimeException {

    public UnmatchedDataException() {
        super(ExceptionMessage.UNMATCHED_DATA.getMessage());
    }
}
