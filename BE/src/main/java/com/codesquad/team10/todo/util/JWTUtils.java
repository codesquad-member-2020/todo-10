package com.codesquad.team10.todo.util;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.SignatureVerificationException;
import com.codesquad.team10.todo.entity.User;

import java.util.HashMap;
import java.util.Map;

public class JWTUtils {

    private static Algorithm algorithm = Algorithm.HMAC256("secret");
    private static String payLoad = "user";

    public static String createTokenByUser(User user) {
        Map<String, Object> data = new HashMap<>();
        data.put("name", user.getName());
        data.put("id", user.getId());
        data.put("boardId", user.getBoard());

        return JWT.create()
                .withIssuer("Jay")
                .withClaim(payLoad, data)
                .sign(algorithm);
    }

    public static User getUserFromJWT(String token) throws SignatureVerificationException {
        Map<String, Object> data = JWT.require(algorithm)
                .build()
                .verify(token)
                .getClaim(payLoad)
                .asMap();
        return new User((Integer)data.get("id"), (String)data.get("name"), null, (Integer)data.get("boardId"), null);
    }

    private JWTUtils() {}
}
