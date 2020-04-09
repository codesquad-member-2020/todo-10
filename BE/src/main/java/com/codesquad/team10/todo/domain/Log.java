package com.codesquad.team10.todo.domain;

import org.springframework.data.annotation.Id;

import java.time.LocalDateTime;

public class Log {

    @Id
    private Long id;
    private User user;
    private Action action;
    private Object target;
    private String source;
    private String destination;
    private LocalDateTime createdDateTime;

    public Log(Long id, User user, Action action, Object target, String source, String destination) {
        this.id = id;
        this.user = user;
        this.action = action;
        this.target = target;
        this.source = source;
        this.destination = destination;
        this.createdDateTime = LocalDateTime.now();
    }

    public Long getId() {
        return id;
    }

    public User getUser() {
        return user;
    }

    public Action getAction() {
        return action;
    }

    public Object getTarget() {
        return target;
    }

    public String getSource() {
        return source;
    }

    public String getDestination() {
        return destination;
    }

    public LocalDateTime getCreatedDateTime() {
        return createdDateTime;
    }
}
