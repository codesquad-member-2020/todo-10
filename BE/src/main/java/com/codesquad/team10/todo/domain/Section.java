package com.codesquad.team10.todo.domain;

import com.codesquad.team10.todo.exception.ResourceNotFoundException;
import com.codesquad.team10.todo.util.DateTimeFormatUtils;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.MappedCollection;

import java.time.LocalDateTime;
import java.util.*;

public class Section {

    @Id
    private int id;
    private String title;
    private List<Card> cards = new LinkedList<>();
    private LocalDateTime createDateTime;
    private LocalDateTime updateDateTime;

    public Section(int id, String title, List<Card> cards, LocalDateTime createDateTime, LocalDateTime updateDateTime) {
        this.id = id;
        this.title = title;
        this.cards = cards;
        this.createDateTime = createDateTime;
        this.updateDateTime = updateDateTime;
    }

    public int getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public List<Card> getCards() {
        return cards;
    }

    public String getCreatedDateTime() {
        return DateTimeFormatUtils.localDateTimeToString(this.createDateTime);
    }

    public String getUpdatedDateTime() {
        return DateTimeFormatUtils.localDateTimeToString(this.updateDateTime);
    }

    public void addCard(Card newCard) {
        cards.add(newCard);
        this.updateDateTime = LocalDateTime.now();
    }

    public Card updateCard(Card updatedCard) {
        for (Card card : cards) {
            if (card.equals(updatedCard)) {
                card.update(updatedCard);
                this.updateDateTime = LocalDateTime.now();
                return card;
            }
        }
        throw new ResourceNotFoundException();
    }

    public boolean deleteCard(int cardId) {
        for (Card card : cards) {
            if (card.getId() == cardId) {
                cards.remove(card);
                return true;
            }
        }
        return false;
    }

    @Override
    public String toString() {
        return "Section{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", cards=" + cards +
                ", createDateTime=" + createDateTime +
                ", updateDateTime=" + updateDateTime +
                '}';
    }
}
