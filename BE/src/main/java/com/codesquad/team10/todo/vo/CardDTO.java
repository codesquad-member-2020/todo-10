package com.codesquad.team10.todo.vo;

import java.time.LocalDateTime;

public class CardDTO {

    private Integer id;

    private String title;

    private String content;

    private LocalDateTime createDateTime;

    private LocalDateTime updateDateTime;

    private String author;

    private boolean deleted;

    private Integer sectionKey;

    public CardDTO(Integer id, String title, String content, LocalDateTime createDateTime, LocalDateTime updateDateTime, String author, boolean deleted, Integer sectionKey) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.createDateTime = createDateTime;
        this.updateDateTime = updateDateTime;
        this.author = author;
        this.deleted = deleted;
        this.sectionKey = sectionKey;
    }

    public Integer getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public String getContent() {
        return content;
    }

    public LocalDateTime getCreateDateTime() {
        return createDateTime;
    }

    public LocalDateTime getUpdateDateTime() {
        return updateDateTime;
    }

    public String getAuthor() {
        return author;
    }

    public Integer getSectionKey() {
        return sectionKey;
    }
}
