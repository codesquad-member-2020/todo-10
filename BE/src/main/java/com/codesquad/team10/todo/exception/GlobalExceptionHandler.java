package com.codesquad.team10.todo.exception;

import com.codesquad.team10.todo.exception.custom.InvalidRequestException;
import com.codesquad.team10.todo.exception.custom.ResourceNotFoundException;
import com.codesquad.team10.todo.exception.custom.UserNotFoundException;
import com.codesquad.team10.todo.response.ResponseData;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(UserNotFoundException.class)
    @ResponseStatus(HttpStatus.UNAUTHORIZED)
    public ResponseData handleUserNotFoundException(UserNotFoundException e) {
        return new ResponseData(ResponseData.Status.ERROR, e.getMessage());
    }

    @ExceptionHandler(ResourceNotFoundException.class)
    @ResponseStatus(HttpStatus.NOT_FOUND)
    public ResponseData handleResourceNotFoundException(ResourceNotFoundException e) {
        return new ResponseData(ResponseData.Status.ERROR, e.getMessage());
    }

    @ExceptionHandler(InvalidRequestException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public ResponseData handleInvalidRequestException(InvalidRequestException e) {
        return new ResponseData(ResponseData.Status.ERROR, e.getMessage());
    }
}
