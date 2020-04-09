package com.codesquad.team10.todo.domain;

import com.codesquad.team10.todo.util.DateTimeFormatUtils;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.time.LocalDateTime;
import java.util.Objects;

public class Card {
    private int id;
    private String title;
    private String content;
    private LocalDateTime createdDateTime;
    private LocalDateTime updatedDateTime;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getCreatedDateTime() {
        return DateTimeFormatUtils.localDateTimeToString(this.createdDateTime);
    }

    public void setCreatedDateTime(LocalDateTime createdDateTime) {
        this.createdDateTime = createdDateTime;
    }

    public String getUpdatedDateTime() {
        return DateTimeFormatUtils.localDateTimeToString(this.updatedDateTime);
    }

    public void setUpdatedDateTime(LocalDateTime updatedDateTime) {
        this.updatedDateTime = updatedDateTime;
    }

    public void update(Card updatedCard) {
        this.title = updatedCard.title;
        this.content = updatedCard.content;
        this.updatedDateTime = LocalDateTime.now();
    }

    @Override
    public String toString() {
        return "Card{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", createdDateTime=" + createdDateTime +
                ", updatedDateTime=" + updatedDateTime +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Card card = (Card) o;
        return id == card.id;
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }
}
