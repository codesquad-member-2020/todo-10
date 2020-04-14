package com.codesquad.team10.todo.vo;

import java.time.LocalDateTime;
import java.util.List;

public class SectionDTO {

    private Integer id;

    private String title;

    private LocalDateTime createDateTime;

    private LocalDateTime updateDateTime;

    private boolean deleted;

    private List<CardDTO> cards;

    private Integer board;

    public SectionDTO(Integer id, String title, LocalDateTime createDateTime, LocalDateTime updateDateTime, boolean deleted, Integer board) {
        this.id = id;
        this.title = title;
        this.createDateTime = createDateTime;
        this.updateDateTime = updateDateTime;
        this.deleted = deleted;
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

    public List<CardDTO> getCards() {
        return cards;
    }

    public void setCards(List<CardDTO> cards) {
        this.cards = cards;
    }
}
