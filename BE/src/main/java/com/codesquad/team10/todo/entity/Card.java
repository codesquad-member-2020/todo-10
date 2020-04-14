package com.codesquad.team10.todo.entity;

import org.springframework.data.annotation.Id;

import java.time.LocalDateTime;
import java.util.Objects;

public class Card {

    @Id
    private Integer id;

    private String title;

    private String content;

    private LocalDateTime createDateTime;

    private LocalDateTime updateDateTime;

    private String author;

    private boolean deleted;

    private Integer user;

    private Integer sectionKey;

    public Card(Integer id, String title, String content, LocalDateTime createDateTime, LocalDateTime updateDateTime, String author, boolean deleted, Integer user, Integer sectionKey) {
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

    public void setAuthor(String author) {
        this.author = author;
    }

    public boolean isDeleted() {
        return deleted;
    }

    public Integer getUser() {
        return user;
    }

    public void setUser(Integer user) {
        this.user = user;
    }

    public Integer getSectionKey() {
        return sectionKey;
    }

    public void update(Card updatedCard) {
        this.title = updatedCard.title;
        this.content = updatedCard.content;
        this.updateDateTime = LocalDateTime.now();
    }

    @Override
    public String toString() {
        return "Card{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", createDateTime=" + createDateTime +
                ", updateDateTime=" + updateDateTime +
                ", author='" + author + '\'' +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Card card = (Card) o;
        return id.equals(card.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }
}
