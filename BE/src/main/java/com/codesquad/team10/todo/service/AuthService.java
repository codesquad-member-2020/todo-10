package com.codesquad.team10.todo.service;

import com.auth0.jwt.exceptions.JWTDecodeException;
import com.auth0.jwt.exceptions.SignatureVerificationException;
import com.codesquad.team10.todo.entity.User;
import com.codesquad.team10.todo.exception.custom.UserNotFoundException;
import com.codesquad.team10.todo.repository.UserRepository;
import com.codesquad.team10.todo.util.JWTUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Service
public class AuthService {

    private static final Logger logger = LoggerFactory.getLogger(AuthService.class);

    private UserRepository userRepository;

    public AuthService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public boolean verifyUser(User loginUser, HttpServletResponse response) {
        User dbUser = userRepository.findByName(loginUser.getName()).orElseThrow(UserNotFoundException::new);
        if (!dbUser.confirmPassword(loginUser))
            return false;

        logger.debug("board id: {}", dbUser.getBoard());

        response.setHeader(HttpHeaders.AUTHORIZATION, JWTUtils.createTokenByUser(dbUser));
        return true;
    }

    public boolean checkAuthorization(HttpServletRequest request) {
        try {
            User userData = JWTUtils.getUserFromJWT(request.getHeader(HttpHeaders.AUTHORIZATION));
            request.setAttribute("user", userData);
        } catch (SignatureVerificationException | JWTDecodeException | NullPointerException e) {
            return false;
        }
        return true;
    }
}
