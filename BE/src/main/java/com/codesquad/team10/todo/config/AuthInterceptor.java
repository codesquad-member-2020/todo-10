package com.codesquad.team10.todo.config;

import com.codesquad.team10.todo.exception.custom.ForbiddenException;
import com.codesquad.team10.todo.service.AuthService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Component
public class AuthInterceptor implements HandlerInterceptor {

    private static final Logger logger = LoggerFactory.getLogger(AuthInterceptor.class);
    private AuthService authService;

    public AuthInterceptor(AuthService authService) {
        this.authService = authService;
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {

        logger.debug("Interceptor preHandle");

        if (request.getMethod().equals("OPTIONS")) {
            logger.debug("options for preflight passed");
            return true;
        }

        if (!authService.checkAuthorization(request))
            throw new ForbiddenException();

        return true;
    }
}
