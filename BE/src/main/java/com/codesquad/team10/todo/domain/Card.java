package com.codesquad.team10.todo.domain;

import com.codesquad.team10.todo.util.DateTimeFormatUtils;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.time.LocalDateTime;

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

    public void update(String title, String content) {
        this.title = title;
        this.content = content;
        this.updatedDateTime = LocalDateTime.now();
    }

    public JsonNode getJSONNode(ObjectMapper mapper) throws JsonProcessingException {
        return mapper.readTree("{ \"id\": \"" + id + "\" }");
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
}
