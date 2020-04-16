package com.codesquad.team10.todo.config;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


@Component
public class SimpleCorsFilter implements Filter {

    private static final Logger logger = LoggerFactory.getLogger(SimpleCorsFilter.class);
    
    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {

        logger.info("doFilter");
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        response.setHeader("Access-Control-Allow-Origin", request.getHeader("Origin"));
        response.setHeader("Access-Control-Allow-Credentials", "true");
        response.setHeader("Access-Control-Allow-Headers", "Origin, Content-Type, Accept, X-Requested-With, Authorization, Access-Control-Request-Method, Access-Control-Request-Headers");
        response.setHeader("Access-Control-Max-Age", "3600");
        response.setHeader("Access-Control-Allow-Methods", "POST, GET, HEAD, OPTIONS, DELETE, PUT, PATCH");
        chain.doFilter(req, res);
    }
}
