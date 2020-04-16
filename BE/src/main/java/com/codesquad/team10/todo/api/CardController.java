package com.codesquad.team10.todo.api;

import com.codesquad.team10.todo.constants.ResponseMessage;
import com.codesquad.team10.todo.entity.*;
import com.codesquad.team10.todo.exception.custom.*;
import com.codesquad.team10.todo.repository.CardRepository;
import com.codesquad.team10.todo.repository.LogRepository;
import com.codesquad.team10.todo.repository.SectionRepository;
import com.codesquad.team10.todo.response.ResponseData;
import com.codesquad.team10.todo.util.ModelMapper;
import com.codesquad.team10.todo.dto.CardDTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/board/section/{sectionId}/card")
public class CardController {

    private static final Logger logger = LoggerFactory.getLogger(CardController.class);

    private SectionRepository sectionRepository;
    private CardRepository cardRepository;
    private LogRepository logRepository;

    public CardController(SectionRepository sectionRepository, CardRepository cardRepository, LogRepository logRepository) {
        this.sectionRepository = sectionRepository;
        this.cardRepository = cardRepository;
        this.logRepository = logRepository;
    }

    @PostMapping("")
    public ResponseEntity<ResponseData> create(@PathVariable int sectionId,
                                               @RequestBody Map<String, String> body,
                                               HttpServletRequest request) {
        User loginUser = (User)request.getAttribute("user");
        Section section = sectionRepository.findById(sectionId).orElseThrow(ResourceNotFoundException::new);
        Card newCard = new Card(body.get("title"), body.get("content"), loginUser.getName(), loginUser.getId());
        section.addCard(newCard);

        logger.debug("new card: {}", newCard);

        // 섹션 내용 변경
        sectionRepository.save(section);
        newCard = cardRepository.findById(newCard.getId()).orElseThrow(ResourceNotFoundException::new);
        // dto 생성
        CardDTO cardDTO = (CardDTO) ModelMapper.of(newCard);
        // 로그 추가
        Log log = new Log(loginUser.getName(), Action.ADDED, Target.CARD, newCard.getTitle(), newCard.getContent(), null, section.getTitle(), loginUser.getBoard());
        logRepository.save(log);
        // 반환 데이터
        Map<String, Object> responseData = constructResonseData(cardDTO, log, section.getCards().size());
        return new ResponseEntity<>(new ResponseData(ResponseData.Status.SUCCESS, responseData), HttpStatus.OK);
    }

    @PatchMapping("/{cardId}")
    public ResponseEntity<ResponseData> update(@PathVariable int sectionId,
                                               @PathVariable int cardId,
                                               @RequestBody Map<String, String> body,
                                               HttpServletRequest request) {
        if (body.get("content") == null)
            throw new InvalidRequestException();

        User loginUser = (User)request.getAttribute("user");
        Section section = sectionRepository.findById(sectionId).orElseThrow(ResourceNotFoundException::new);
        Card updateCard = cardRepository.findById(cardId).orElseThrow(ResourceNotFoundException::new);
        if (section.getCards().size() == 0)
            throw new UnmatchedRequestDataException();

        // 카드 내용 수정
        CardDTO resultCard = (CardDTO) ModelMapper.of(section.updateCard(updateCard, body.get("title"), body.get("content")));
        sectionRepository.save(section);
        // 로그 추가
        Log log = new Log(loginUser.getName(), Action.UPDATED, Target.CARD, resultCard.getTitle(), resultCard.getContent(), null, null, loginUser.getBoard());
        logRepository.save(log);
        logger.debug("log: {}", log);
        //반환 데이터
        Map<String, Object> responseData = constructResonseData(resultCard, log, section.getCards().size());
        return new ResponseEntity<>(new ResponseData(ResponseData.Status.SUCCESS, responseData), HttpStatus.OK);
    }

    @DeleteMapping("/{cardId}")
    public ResponseEntity<ResponseData> delete(@PathVariable int sectionId,
                                               @PathVariable int cardId,
                                               HttpServletRequest request) {
        User loginUser = (User)request.getAttribute("user");
        Card targetCard = cardRepository.findById(cardId).orElseThrow(ResourceNotFoundException::new);
        Section section = sectionRepository.findById(sectionId).orElseThrow(ResourceNotFoundException::new);
        if (section.getCards().size() == 0)
            throw new UnmatchedRequestDataException();

        section.deleteCard(targetCard);
        sectionRepository.save(section);
        Log log = new Log(loginUser.getName(), Action.REMOVED, Target.CARD, targetCard.getTitle(), targetCard.getContent(), section.getTitle(), null, loginUser.getBoard());
        logRepository.save(log);
        logger.debug("log: {}", log);
        Map<String, Object> responseData = constructResonseData(log, section.getCards().size());
        return new ResponseEntity<>(new ResponseData(ResponseData.Status.SUCCESS, responseData), HttpStatus.OK);
    }

    @PutMapping("/{cardId}")
    public ResponseEntity<ResponseData> move(@PathVariable int sectionId,
                                             @PathVariable int cardId,
                                             @RequestParam int cardTo,
                                             @RequestParam(required = false) Integer sectionTo,
                                             HttpServletRequest request) {
        User loginUser = (User)request.getAttribute("user");
        Card moveCard = cardRepository.findById(cardId).orElseThrow(ResourceNotFoundException::new);

        if (sectionTo == null) {
            if (moveCard.getSectionKey() == cardTo)
                return new ResponseEntity<>(new ResponseData(ResponseData.Status.ERROR, ResponseMessage.CARD_NOT_MOVED.getMessage()), HttpStatus.BAD_REQUEST);

            Section section = sectionRepository.findById(sectionId).orElseThrow(ResourceNotFoundException::new);
            if (section.getCards().size() <= cardTo)
                throw new UnmatchedRequestDataException();

            section.moveCard(moveCard, cardTo);
            sectionRepository.save(section);
            Log log = new Log(loginUser.getName(), Action.MOVED, Target.CARD, moveCard.getTitle(), moveCard.getContent(), section.getTitle(), null, loginUser.getBoard());
            // dto 생성
            CardDTO cardDTO = (CardDTO) ModelMapper.of(moveCard);
            logRepository.save(log);
            logger.debug("log: {}", log);
            Map<String, Object> responseData = constructResonseData(log, section.getCards().size(), null);
            return new ResponseEntity<>(new ResponseData(ResponseData.Status.SUCCESS, responseData), HttpStatus.OK);
        }
        if (sectionId == sectionTo)
            return new ResponseEntity<>(new ResponseData(ResponseData.Status.ERROR, ResponseMessage.CARD_NOT_MOVED.getMessage()), HttpStatus.BAD_REQUEST);

        Section fromSection = sectionRepository.findById(sectionId).orElseThrow(ResourceNotFoundException::new);
        Section toSection = sectionRepository.findById(sectionTo).orElseThrow(ResourceNotFoundException::new);
        if (toSection.getCards().size() != 0 && toSection.getCards().size() < cardTo)
            throw new UnmatchedRequestDataException();

        fromSection.deleteCard(moveCard);
        toSection.insertCard(cardTo, moveCard);
        sectionRepository.save(fromSection);
        sectionRepository.save(toSection);
        Log log = new Log(loginUser.getName(), Action.MOVED, Target.CARD, moveCard.getTitle(), moveCard.getContent(), fromSection.getTitle(), toSection.getTitle(), loginUser.getBoard());
        // dto 생성
        CardDTO cardDTO = (CardDTO) ModelMapper.of(moveCard);
        logRepository.save(log);
        logger.debug("log: {}", log);
        Map<String, Object> responseData = constructResonseData(log, fromSection.getCards().size(), toSection.getCards().size());
        return new ResponseEntity<>(new ResponseData(ResponseData.Status.SUCCESS, responseData), HttpStatus.OK);
    }

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
