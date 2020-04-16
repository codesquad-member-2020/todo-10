package com.codesquad.team10.todo.api;

import com.auth0.jwt.exceptions.JWTDecodeException;
import com.auth0.jwt.exceptions.SignatureVerificationException;
import com.codesquad.team10.todo.entity.*;
import com.codesquad.team10.todo.exception.custom.*;
import com.codesquad.team10.todo.repository.CardRepository;
import com.codesquad.team10.todo.repository.LogRepository;
import com.codesquad.team10.todo.repository.SectionRepository;
import com.codesquad.team10.todo.response.ResponseData;
import com.codesquad.team10.todo.util.JWTUtils;
import com.codesquad.team10.todo.util.ModelMapper;
import com.codesquad.team10.todo.dto.CardDTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
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
    public ResponseEntity<ResponseData> create(@PathVariable int sectionId, @RequestBody Map<String, String> body, HttpServletRequest request) {
        User userData = null;
        try {
            userData = JWTUtils.getUserFromJWT(request.getHeader(HttpHeaders.AUTHORIZATION));
        } catch (SignatureVerificationException | NullPointerException e) {
            throw new ForbiddenException();
        } catch (JWTDecodeException e) {
            throw new InvalidTokenException();
        }
        Section section = sectionRepository.findById(sectionId).orElseThrow(ResourceNotFoundException::new);
        Card newCard = new Card(body.get("title"), body.get("content"), userData.getName(), userData.getId());
        section.addCard(newCard);

        logger.debug("new card: {}", newCard);

        // 섹션 내용 변경
        sectionRepository.save(section);
        newCard = cardRepository.findById(newCard.getId()).orElseThrow(ResourceNotFoundException::new);
        // dto 생성
        CardDTO cardDTO = null;
        cardDTO = (CardDTO) ModelMapper.of(newCard);
        // 로그 추가
        Log log = new Log(userData.getName(), Action.ADDED, Target.CARD, newCard.getTitle(), newCard.getContent(), null, section.getTitle(), userData.getBoard());
        logRepository.save(log);
        // 반환 데이터
        Map<String, Object> responseData = constructResonseData(cardDTO, log, getCountOfCardWithoutDeleted(section.getCards()));
        return new ResponseEntity<>(new ResponseData(ResponseData.Status.SUCCESS, responseData), HttpStatus.OK);
    }

    @PatchMapping("/{cardId}")
    public ResponseEntity<ResponseData> update(@PathVariable int sectionId, @PathVariable int cardId, @RequestBody Map<String, String> body, HttpServletRequest request) {
        if (body.get("content") == null) {
            throw new InvalidRequestException();
        }
        User userData = null;
        try {
            userData = JWTUtils.getUserFromJWT(request.getHeader(HttpHeaders.AUTHORIZATION));
        } catch (SignatureVerificationException | NullPointerException e) {
            throw new ForbiddenException();
        } catch (JWTDecodeException e) {
            throw new InvalidTokenException();
        }
        Card updateCard = cardRepository.findById(cardId).orElseThrow(ResourceNotFoundException::new);
        Section section = sectionRepository.findById(sectionId).orElseThrow(ResourceNotFoundException::new);
        if (section.getCards().size() == 0)
            throw new UnmatchedRequestDataException();

        // 카드 내용 수정
        CardDTO resultCard = (CardDTO) ModelMapper.of(section.updateCard(updateCard, body.get("title"), body.get("content")));
        sectionRepository.save(section);
        // 로그 추가
        Log log = new Log(userData.getName(), Action.UPDATED, Target.CARD, resultCard.getTitle(), resultCard.getContent(), null, null, userData.getBoard());
        logRepository.save(log);
        logger.debug("log: {}", log);
        //반환 데이터
        Map<String, Object> responseData = constructResonseData(resultCard, log, getCountOfCardWithoutDeleted(section.getCards()));
        return new ResponseEntity<>(new ResponseData(ResponseData.Status.SUCCESS, responseData), HttpStatus.OK);
    }

    @DeleteMapping("/{cardId}")
    public ResponseEntity<ResponseData> delete(@PathVariable int sectionId, @PathVariable int cardId, HttpServletRequest request) {
        User userData = null;
        try {
            userData = JWTUtils.getUserFromJWT(request.getHeader(HttpHeaders.AUTHORIZATION));
        } catch (SignatureVerificationException | NullPointerException e) {
            throw new ForbiddenException();
        } catch (JWTDecodeException e) {
            throw new InvalidTokenException();
        }
        Card targetCard = cardRepository.findById(cardId).orElseThrow(ResourceNotFoundException::new);
        if (targetCard.isDeleted())
            throw new ResourceNotFoundException();

        Section section = sectionRepository.findById(sectionId).orElseThrow(ResourceNotFoundException::new);
        if (section.getCards().size() == 0)
            throw new UnmatchedRequestDataException();

        section.deleteCard(targetCard);
        sectionRepository.save(section);
        Log log = new Log(userData.getName(), Action.REMOVED, Target.CARD, targetCard.getTitle(), targetCard.getContent(), section.getTitle(), null, userData.getBoard());
        logRepository.save(log);
        logger.debug("log: {}", log);
        Map<String, Object> responseData = constructResonseData(log, getCountOfCardWithoutDeleted(section.getCards()));
        return new ResponseEntity<>(new ResponseData(ResponseData.Status.SUCCESS, responseData), HttpStatus.OK);
    }

    private Map<String, Object> constructResonseData(CardDTO cardDTO, Log log, long countOfCard) {
        Map<String, Object> map = new HashMap<>();
        map.put("card", cardDTO);
        map.put("log_id", log.getId());
        map.put("card_count", countOfCard);
        return map;
    }

    private Map<String, Object> constructResonseData(Log log, long countOfCard) {
        Map<String, Object> map = new HashMap<>();
        map.put("log_id", log.getId());
        map.put("card_count", countOfCard);
        return map;
    }

    private long getCountOfCardWithoutDeleted(List<Card> cards) {
        return cards.stream()
                .filter(card -> !card.isDeleted())
                .count();
    }
}
