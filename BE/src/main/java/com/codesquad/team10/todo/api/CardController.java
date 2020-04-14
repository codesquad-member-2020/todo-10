package com.codesquad.team10.todo.api;

import com.codesquad.team10.todo.entity.*;
import com.codesquad.team10.todo.exception.custom.InvalidRequestException;
import com.codesquad.team10.todo.exception.custom.ResourceNotFoundException;
import com.codesquad.team10.todo.repository.CardRepository;
import com.codesquad.team10.todo.repository.LogRepository;
import com.codesquad.team10.todo.repository.SectionRepository;
import com.codesquad.team10.todo.response.ResponseData;
import com.codesquad.team10.todo.util.ModelMapper;
import com.codesquad.team10.todo.vo.CardDTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/board/section/{sectionId}/card")
public class CardController {

    private static final Logger logger = LoggerFactory.getLogger(CardController.class);

    private static final Integer TEST_BOARD_ID = 1;
    private static final String TEST_USER_NAME = "nigayo";
    private static final Integer TEST_USER_ID = 1;

    private SectionRepository sectionRepository;
    private CardRepository cardRepository;
    private LogRepository logRepository;

    public CardController(SectionRepository sectionRepository, CardRepository cardRepository, LogRepository logRepository) {
        this.sectionRepository = sectionRepository;
        this.cardRepository = cardRepository;
        this.logRepository = logRepository;
    }

    @PostMapping("")
    public ResponseEntity<ResponseData> create(@PathVariable int sectionId, @RequestBody Card card) {
        Section section = sectionRepository.findById(sectionId).orElseThrow(ResourceNotFoundException::new);
        card.setAuthor(TEST_USER_NAME);
        card.setUser(TEST_USER_ID);
        section.addCard(card);

        logger.debug("new card: {}", card);

        // 섹션 내용 변경
        sectionRepository.save(section);
        card = cardRepository.findById(card.getId()).orElseThrow(ResourceNotFoundException::new);
        // dto 생성
        CardDTO cardDTO = null;
        cardDTO = (CardDTO)ModelMapper.of(card);
        // 로그 추가
        Log log = new Log(TEST_USER_NAME, Action.ADDED, Target.CARD, substractTarget(cardDTO.getTitle(), cardDTO.getContent()), null, section.getTitle(), TEST_BOARD_ID);
        logRepository.save(log);
        // 반환 데이터
        return new ResponseEntity<>(new ResponseData(ResponseData.Status.SUCCESS, constructResonseData(cardDTO, log, section.getCards().size())), HttpStatus.OK);
    }

    @PatchMapping("/{cardId}")
    public ResponseEntity<ResponseData> update(@PathVariable int sectionId, @PathVariable int cardId, @RequestBody CardDTO card) {
        if (card.getCardIndex() == null)
            throw new InvalidRequestException();

        Section section = sectionRepository.findById(sectionId).orElseThrow(ResourceNotFoundException::new);
        CardDTO resultCard = null;
        Map<String, Object> responseData = null;
        try {
            // 카드 내용 수정
            section.updateCard((Card)ModelMapper.of(card));
            sectionRepository.save(section);
            // updateCreateTime 반영된 시간 받아오기 위해서 레포지토리에서 Get
            resultCard = (CardDTO)ModelMapper.of(cardRepository.findById(cardId).orElseThrow(ResourceNotFoundException::new));
            // 로그 추가
            Log log = new Log(TEST_USER_NAME, Action.UPDATED, Target.CARD, substractTarget(card.getTitle() ,card.getContent()), null, null, TEST_BOARD_ID);
            logRepository.save(log);
            logger.debug("log: {}", log);
            //반환 데이터
            responseData = constructResonseData(resultCard, log, section.getCards().size());
        } catch (IndexOutOfBoundsException e) {
            throw new ResourceNotFoundException();
        }
        return new ResponseEntity<>(new ResponseData(ResponseData.Status.SUCCESS, responseData), HttpStatus.OK);
    }

    private String substractTarget(String title, String content) {
        if (title != null)
            return title;

        final String delimiter = "\r\n";
        if (content.contains(delimiter)) {
            return content.substring(0, content.indexOf(delimiter));
        }
        return content;
    }

    private Map<String, Object> constructResonseData(CardDTO cardDTO, Log log, int cardCount) {
        Map<String, Object> map = new HashMap<>();
        map.put("card", cardDTO);
        map.put("log_id", log.getId());
        map.put("card_count", cardCount);
        return map;
    }
}
