package com.codesquad.team10.todo.domain;

import java.util.LinkedList;
import java.util.List;

public class User {

    private Long id;
    private String email;
    private String password;
    private List<Section> sections = new LinkedList<>();

    public User(Long id, String email, String password) {
        this.id = id;
        this.email = email;
        this.password = password;
    }

    public Long getId() {
        return id;
    }

    public String getEmail() {
        return email;
    }

    public String getPassword() {
        return password;
    }

    public List<Section> getSections() {
        return sections;
    }
}
