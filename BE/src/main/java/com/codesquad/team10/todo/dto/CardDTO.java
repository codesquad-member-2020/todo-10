package com.codesquad.team10.todo.dto;

import com.codesquad.team10.todo.util.DateTimeFormatUtils;
import com.fasterxml.jackson.annotation.JsonIgnore;

import java.time.LocalDateTime;

public class CardDTO {

    private Integer id;

    private String title;

    private String content;

    private LocalDateTime createDateTime;

    private LocalDateTime updateDateTime;

    private String author;

    @JsonIgnore
    private boolean deleted;

    @JsonIgnore
    private Integer user;

    @JsonIgnore
    private Integer sectionKey;

    public CardDTO(Integer id, String title, String content, LocalDateTime createDateTime, LocalDateTime updateDateTime, String author, boolean deleted, Integer user, Integer sectionKey) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.createDateTime = createDateTime;
        this.updateDateTime = updateDateTime;
        this.author = author;
        this.deleted = deleted;
        this.user = user;
        this.sectionKey = sectionKey;
    }

    public Integer getId() {
        return id;
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

    public String getCreateDateTime() {
        return createDateTime == null ? null : DateTimeFormatUtils.localDateTimeToString(createDateTime);
    }

    public String getUpdateDateTime() {
        return updateDateTime == null ? null : DateTimeFormatUtils.localDateTimeToString(updateDateTime);
    }

    public String getAuthor() {
        return author;
    }

    public boolean isDeleted() {
        return deleted;
    }

    public Integer getUser() {
        return user;
    }

    public Integer getSectionKey() {
        return sectionKey;
    }

    public void setSectionKey(Integer sectionKey) {
        this.sectionKey = sectionKey;
    }
}
