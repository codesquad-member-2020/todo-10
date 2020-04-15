package com.codesquad.team10.todo.entity;

import org.springframework.data.annotation.Id;

import java.util.ArrayList;
import java.util.List;

public class Board {

    @Id
    private Integer id;

    private List<User> users = new ArrayList<>();

    public Board(Integer id, List<User> users) {
        this.id = id;
        this.users = users;
    }
}
