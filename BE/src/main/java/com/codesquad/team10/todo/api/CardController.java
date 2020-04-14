package com.codesquad.team10.todo.api;

import com.codesquad.team10.todo.entity.*;
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

import java.lang.reflect.InvocationTargetException;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/board/section/{sectionId}/card")
public class CardController {

    private static final Logger log = LoggerFactory.getLogger(CardController.class);

    private static final Integer TEST_BOARD_ID = 1;
    private static final String TEST_USER_NAME = "nigayo";

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
        section.addCard(card);

        log.debug("new card: {}", card);

        // 섹션 내용 변경
        sectionRepository.save(section);
        card = cardRepository.findById(card.getId()).orElseThrow(ResourceNotFoundException::new);
        // dto 생성
        CardDTO cardDTO = null;
        cardDTO = (CardDTO)ModelMapper.of(card);
        // 로그 추가
        Log log = new Log(TEST_USER_NAME, Action.ADDED, Target.CARD, card.getTitle() + card.getContent(), null, section.getTitle(), TEST_BOARD_ID);
        logRepository.save(log);

        Map<String, Object> responsedata = new HashMap<>();
        responsedata.put("card", cardDTO);
        responsedata.put("log_id", log.getId());
        responsedata.put("card_count", section.getCards().size());
        return new ResponseEntity<>(new ResponseData(ResponseData.Status.SUCCESS, responsedata), HttpStatus.OK);
    }
}
