package com.codesquad.team10.todo.util;

import com.codesquad.team10.todo.entity.Card;
import com.codesquad.team10.todo.entity.Log;
import com.codesquad.team10.todo.entity.Section;
import com.codesquad.team10.todo.vo.CardDTO;
import com.codesquad.team10.todo.vo.LogDTO;
import com.codesquad.team10.todo.vo.SectionDTO;

public class ModelMapper {

    private static String VO_PACKAGE = "com.codesquad.team10.todo.vo.";

    public static <T> Object of(T object) {
        String className = object.getClass().getName();
        className = className.substring(className.lastIndexOf(".") + 1);
        switch (className) {
            case "Card":
                Card card = (Card)object;
                return new CardDTO(
                        card.getId(),
                        card.getTitle(),
                        card.getContent(),
                        card.getCreateDateTime(),
                        card.getUpdateDateTime(),
                        card.getAuthor(),
                        card.isDeleted(),
                        card.getUser(),
                        card.getSectionKey());
            case "CardDTO":
                CardDTO cardDTO = (CardDTO)object;
                return new Card(
                        cardDTO.getId(),
                        cardDTO.getTitle(),
                        cardDTO.getContent(),
                        cardDTO.getCreateDateTime() == null ? null : DateTimeFormatUtils.stringToLocalDateTime(cardDTO.getCreateDateTime()),
                        cardDTO.getUpdateDateTime() == null ? null : DateTimeFormatUtils.stringToLocalDateTime(cardDTO.getUpdateDateTime()),
                        cardDTO.getAuthor(),
                        cardDTO.isDeleted(),
                        cardDTO.getUser(),
                        cardDTO.getSectionKey()
                );
            case "Section":
                Section section = (Section)object;
                return new SectionDTO(
                  section.getId(),
                  section.getTitle(),
                  section.getCreateDateTime(),
                  section.getUpdateDateTime(),
                  section.isDeleted(),
                  section.getBoard()
                );
            case "Log":
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
