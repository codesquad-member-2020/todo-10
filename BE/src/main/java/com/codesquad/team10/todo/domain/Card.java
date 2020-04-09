package com.codesquad.team10.todo.domain;

import com.codesquad.team10.todo.util.DateTimeFormatUtils;
import org.springframework.data.annotation.Id;

import java.time.LocalDateTime;
import java.util.Objects;

public class Card {

    @Id
    private int id;
    private String title;
    private String content;
    private LocalDateTime createDateTime;
    private LocalDateTime updateDateTime;

    public Card(int id, String title, String content, LocalDateTime createDateTime, LocalDateTime updateDateTime) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.createDateTime = createDateTime;
        this.updateDateTime = updateDateTime;
    }

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
        return DateTimeFormatUtils.localDateTimeToString(this.createDateTime);
    }

    public void setCreatedDateTime(LocalDateTime createDateTime) {
        this.createDateTime = createDateTime;
    }

    public String getUpdatedDateTime() {
        return DateTimeFormatUtils.localDateTimeToString(this.updateDateTime);
    }

    public void setUpdatedDateTime(LocalDateTime updatedDateTime) {
        this.updateDateTime = updatedDateTime;
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
                ", createdDateTime=" + createDateTime +
                ", updatedDateTime=" + updateDateTime +
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
