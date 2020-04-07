package com.codesquad.team10.todo.domain;

import java.util.LinkedList;
import java.util.List;

public class User {

    private Long id;
    private String email;
    private String password;
    private List<Section> sections = new LinkedList<>();

    public Long getId() {
        return id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public List<Section> getSections() {
        return sections;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", email='" + email + '\'' +
                ", password='" + password + '\'' +
                ", sections=" + sections +
                '}';
    }
}
