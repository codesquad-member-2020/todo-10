package com.codesquad.team10.todo.domain;

import org.springframework.data.annotation.Id;

import java.time.LocalDateTime;

public class Log {

    @Id
    private Long id;
    private Action action;
    private String source;
    private String destination;
    private LocalDateTime createDateTime;

    public Log(Long id, Action action, String source, String destination, LocalDateTime createDateTime) {
        this.id = id;
        this.action = action;
        this.source = source;
        this.destination = destination;
        this.createDateTime = createDateTime;
    }

    public Long getId() {
        return id;
    }

    public Action getAction() {
        return action;
    }

    public String getSource() {
        return source;
    }

    public String getDestination() {
        return destination;
    }

    public LocalDateTime getCreatedDateTime() {
        return createDateTime;
    }
}
