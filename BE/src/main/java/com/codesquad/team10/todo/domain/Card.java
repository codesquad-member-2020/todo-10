package com.codesquad.team10.todo.domain;

import java.time.LocalDateTime;

public class Card {

    private Long id;
    private String title;
    private String content;
    private Route route;
    private LocalDateTime createdDateTime;
    private LocalDateTime updatedDateTime;

    public Card(Long id, String title, String content, Route route) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.route = route;
        this.createdDateTime = LocalDateTime.now();
        this.updatedDateTime = LocalDateTime.now();
    }

    public Long getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public String getContent() {
        return content;
    }

    public Route getRoute() {
        return route;
    }

    public LocalDateTime getCreatedDateTime() {
        return createdDateTime;
    }

    public LocalDateTime getUpdatedDateTime() {
        return updatedDateTime;
    }
}
