package com.codesquad.team10.todo.entity;

import com.codesquad.team10.todo.exception.custom.UnmatchedRequestDataException;
import org.springframework.data.annotation.Id;

import java.time.LocalDateTime;
import java.util.List;

public class Section {

    @Id
    private Integer id;

    private String title;

    private LocalDateTime createDateTime;

    private LocalDateTime updateDateTime;

    private boolean deleted;

    private List<Card> cards;

    private Integer board;

    public Section(Integer id, String title, LocalDateTime createDateTime, LocalDateTime updateDateTime, boolean deleted, List<Card> cards, Integer board) {
        this.id = id;
        this.title = title;
        this.createDateTime = createDateTime;
        this.updateDateTime = updateDateTime;
        this.deleted = deleted;
        this.cards = cards;
        this.board = board;
    }

    public Integer getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public LocalDateTime getCreateDateTime() {
        return createDateTime;
    }

    public LocalDateTime getUpdateDateTime() {
        return updateDateTime;
    }

    public boolean isDeleted() {
        return deleted;
    }

    public List<Card> getCards() {
        return cards;
    }

    public void setCards(List<Card> cards) {
        this.cards = cards;
    }

    public Integer getBoard() {
        return board;
    }

    public void addCard(Card newCard) {
        cards.add(newCard);
    }

    public Card updateCard(Card updateCard, String title, String content) {
        Card target = cards.get(updateCard.getSectionKey());
        if (!target.equals(updateCard))
            throw new UnmatchedRequestDataException();

        return target.update(title, content);
    }

    public void deleteCard(Card deleteCard) {
        Card target = cards.get(deleteCard.getSectionKey());
        if (!target.equals(deleteCard))
            throw new UnmatchedRequestDataException();

        target.setDeleted(true);
    }

    @Override
    public String toString() {
        return "Section{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", createDateTime=" + createDateTime +
                ", updateDateTime=" + updateDateTime +
                ", deleted=" + deleted +
                ", cards=" + cards +
                ", board=" + board +
                '}';
    }
}
