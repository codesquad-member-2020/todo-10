package com.codesquad.team10.todo.domain;

import com.codesquad.team10.todo.util.DateTimeFormatUtils;
import org.springframework.data.annotation.Id;

import java.time.LocalDateTime;
import java.util.*;

public class Section {

    @Id
    private int id;
    private String title;
    private List<Card> cards = new LinkedList<>();
    private LocalDateTime createdDateTime;
    private LocalDateTime updatedDateTime;

    public Section(int id, String title) {
        this.id = id;
        this.title = title;
        this.createdDateTime = LocalDateTime.now();
        this.updatedDateTime = LocalDateTime.now();
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
        return DateTimeFormatUtils.localDateTimeToString(this.createdDateTime);
    }

    public String getUpdatedDateTime() {
        return DateTimeFormatUtils.localDateTimeToString(this.updatedDateTime);
    }

    public void addCard(Card newCard) {
        cards.add(newCard);
        this.updatedDateTime = LocalDateTime.now();
    }

    public Card updateCard(Card updatedCard) {
        for (Card card : cards) {
            if (card.equals(updatedCard)) {
                card.update(updatedCard);
                this.updatedDateTime = LocalDateTime.now();
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
}
