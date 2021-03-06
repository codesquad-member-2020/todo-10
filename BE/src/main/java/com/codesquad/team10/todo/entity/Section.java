package com.codesquad.team10.todo.entity;

import com.codesquad.team10.todo.exception.custom.UnmatchedRequestDataException;
import org.springframework.data.annotation.Id;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class Section {

    @Id
    private Integer id;

    private String title;

    private LocalDateTime createDateTime;

    private LocalDateTime updateDateTime;

    private List<Card> cards;

    private Integer board;

    public Section() {}

    public Section(String title, Integer board) {
        this.title = title;
        this.board = board;
        this.cards = new ArrayList<>();
    }

    public Section(Integer id, String title, LocalDateTime createDateTime, LocalDateTime updateDateTime, List<Card> cards, Integer board) {
        this.id = id;
        this.title = title;
        this.createDateTime = createDateTime;
        this.updateDateTime = updateDateTime;
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

    public void insertCard(int index, Card insertCard) {
        cards.add(index, insertCard);
    }

    public Card updateCard(Card updateCard, String title, String content) {
        Card target = null;
        try {
            target = cards.get(updateCard.getSectionKey());
        } catch (IndexOutOfBoundsException e) {
            throw new UnmatchedRequestDataException();
        }
        if (!target.equals(updateCard))
            throw new UnmatchedRequestDataException();

        return target.update(title, content);
    }

    public void deleteCard(Card deleteCard) {
        Card target = null;
        try {
            target = cards.get(deleteCard.getSectionKey());
        } catch (IndexOutOfBoundsException e) {
            throw new UnmatchedRequestDataException();
        }
        if (!target.equals(deleteCard))
            throw new UnmatchedRequestDataException();

        cards.remove(target);
    }

    public void moveCard(Card moveCard, int cardTo) {
        Card target = null;
        try {
            target = cards.get(moveCard.getSectionKey());
        } catch (IndexOutOfBoundsException e) {
            throw new UnmatchedRequestDataException();
        }
        if (!target.equals(moveCard))
            throw new UnmatchedRequestDataException();

        cards.remove(target);
        cards.add(cardTo, target);
    }

    @Override
    public String toString() {
        return "Section{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", createDateTime=" + createDateTime +
                ", updateDateTime=" + updateDateTime +
                ", cards=" + cards +
                ", board=" + board +
                '}';
    }
}
