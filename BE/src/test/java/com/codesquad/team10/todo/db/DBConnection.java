package com.codesquad.team10.todo.db;

import org.junit.jupiter.api.Test;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";
    private static final String URL = "jdbc:mysql://15.164.63.83:3306/TEST_KANBANBOARD";
    private static final String USER = "springbootUser";
    private static final String PW = "sBu_1234!";

    @Test
    public void testConnection() throws Exception {
        Class.forName(DRIVER);
        try (Connection con = DriverManager.getConnection(URL, USER, PW)) {
            System.out.println(con);
        } catch (Exception e) {
            System.err.println(e);
        }
    }
}
