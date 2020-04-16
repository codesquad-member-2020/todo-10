package com.codesquad.team10.todo.service;

import com.codesquad.team10.todo.dto.CardDTO;
import com.codesquad.team10.todo.entity.*;
import com.codesquad.team10.todo.repository.LogRepository;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class LogService {

    private LogRepository logRepository;

    public LogService(LogRepository logRepository) {
        this.logRepository = logRepository;
    }

    // 카드 추가, 수정 로그
    public Map<String, Object> getResponseDataWithLog(Action action, CardDTO card, Section section, User user) {
        switch (action) {
            case ADDED: {
                Log log = new Log(user.getName(), action, Target.CARD, card.getTitle(), card.getContent(), null, section.getTitle(), user.getBoard());
                logRepository.save(log);
                return constructResonseData(card, log, section.getCards().size());
            }
            case UPDATED: {
                Log log = new Log(user.getName(), action, Target.CARD, card.getTitle(), card.getContent(), null, null, user.getBoard());
                logRepository.save(log);
                return constructResonseData(card, log, section.getCards().size());
            }
        }
        return null;
    }

    // 카드 삭제, 이동 로그 (동일 컬럼 내)
    public Map<String, Object> getResponseDataWithLog(Action action, Card card, Section section, User user) {
        switch (action) {
            case REMOVED: {
                Log log = new Log(user.getName(), action, Target.CARD, card.getTitle(), card.getContent(), section.getTitle(), null, user.getBoard());
                logRepository.save(log);
                return constructResonseData(log, section.getCards().size());
            }
            case MOVED: {
                Log log = new Log(user.getName(), action, Target.CARD, card.getTitle(), card.getContent(), section.getTitle(), null, user.getBoard());
                logRepository.save(log);
                return constructResonseData(log, section.getCards().size(), null);
            }
        }
        return null;
    }

    // 카드 이동 로그 (다른 섹션)
    public Map<String, Object> getResponseDataWithLog(Card moveCard, Section fromSection, Section toSection, User user) {
        Log log = new Log(user.getName(), Action.MOVED, Target.CARD, moveCard.getTitle(), moveCard.getContent(), fromSection.getTitle(), toSection.getTitle(), user.getBoard());
        logRepository.save(log);
        return constructResonseData(log, fromSection.getCards().size(), toSection.getCards().size());
    }

    // 응답 데이터 생성
    private Map<String, Object> constructResonseData(CardDTO cardDTO, Log log, Integer countOfCard) {
        Map<String, Object> map = new HashMap<>();
        map.put("card", cardDTO);
        map.put("log_id", log.getId());
        map.put("card_count", countOfCard);
        return map;
    }

    private Map<String, Object> constructResonseData(Log log, Integer countOfCard) {
        Map<String, Object> map = new HashMap<>();
        map.put("log_id", log.getId());
        map.put("card_count", countOfCard);
        return map;
    }

    private Map<String, Object> constructResonseData(Log log, Integer countOfCardFromSection, Integer countOfCardToSection) {
        Map<String, Object> map = new HashMap<>();
        map.put("log_id", log.getId());
        map.put("card_count_from_section", countOfCardFromSection);
        map.put("card_count_to_section", countOfCardToSection);
        return map;
    }
}
