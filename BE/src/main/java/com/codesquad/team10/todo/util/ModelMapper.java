package com.codesquad.team10.todo.util;

import com.codesquad.team10.todo.entity.Card;
import com.codesquad.team10.todo.entity.Log;
import com.codesquad.team10.todo.entity.Section;
import com.codesquad.team10.todo.dto.CardDTO;
import com.codesquad.team10.todo.dto.LogDTO;
import com.codesquad.team10.todo.dto.SectionDTO;

import java.util.stream.Collectors;

public class ModelMapper {

    public static <T> Object of(T object) {
        if (object instanceof Card) {
            Card card = (Card)object;
            return new CardDTO(
                    card.getId(),
                    card.getTitle(),
                    card.getContent(),
                    card.getCreateDateTime(),
                    card.getUpdateDateTime(),
                    card.getAuthor(),
                    card.getUser(),
                    card.getSectionKey());
        }
        if (object instanceof CardDTO) {
            CardDTO cardDTO = (CardDTO)object;
            return new Card(
                    cardDTO.getId(),
                    cardDTO.getTitle(),
                    cardDTO.getContent(),
                    cardDTO.getCreateDateTime() == null ? null : DateTimeFormatUtils.stringToLocalDateTime(cardDTO.getCreateDateTime()),
                    cardDTO.getUpdateDateTime() == null ? null : DateTimeFormatUtils.stringToLocalDateTime(cardDTO.getUpdateDateTime()),
                    cardDTO.getAuthor(),
                    cardDTO.getUser(),
                    cardDTO.getSectionKey()
            );
        }
        if (object instanceof Section) {
            Section section = (Section)object;
            return new SectionDTO(
                    section.getId(),
                    section.getTitle(),
                    section.getCreateDateTime(),
                    section.getUpdateDateTime(),
                    section.getCards().stream().map(card -> (CardDTO)of(card)).collect(Collectors.toList()),
                    section.getBoard()
            );
        }
        if (object instanceof Log) {
            Log log = (Log)object;
            return new LogDTO(
                    log.getId(),
                    log.getUser(),
                    log.getAction(),
                    log.getTarget(),
                    log.getTitle(),
                    log.getContent(),
                    log.getSource(),
                    log.getDestination(),
                    log.getCreateDateTime(),
                    log.getBoard()
            );
        }
        return null;
    }

    private ModelMapper() {}
}
