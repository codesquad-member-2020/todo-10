package com.codesquad.team10.todo.domain;

import java.time.LocalDateTime;
import java.util.LinkedList;
import java.util.List;

public class Section {

    private Long id;
    private String title;
    private List<Card> cards = new LinkedList<>();
    private LocalDateTime createdDateTime;
    private LocalDateTime updatedDateTime;

    public Section(Long id, String title) {
        this.id = id;
        this.title = title;
        this.createdDateTime = LocalDateTime.now();
        this.updatedDateTime = LocalDateTime.now();
    }

    public Long getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public List<Card> getCards() {
        return cards;
    }

    public LocalDateTime getCreatedDateTime() {
        return createdDateTime;
    }

    public LocalDateTime getUpdatedDateTime() {
        return updatedDateTime;
    }
}
