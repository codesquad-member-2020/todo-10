package com.codesquad.team10.todo.api;

import com.codesquad.team10.todo.constants.ResponseMessage;
import com.codesquad.team10.todo.entity.*;
import com.codesquad.team10.todo.exception.custom.*;
import com.codesquad.team10.todo.repository.CardRepository;
import com.codesquad.team10.todo.repository.SectionRepository;
import com.codesquad.team10.todo.response.ResponseData;
import com.codesquad.team10.todo.service.LogService;
import com.codesquad.team10.todo.util.ModelMapper;
import com.codesquad.team10.todo.dto.CardDTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

@RestController
@RequestMapping("/board/section/{sectionId}/card")
public class CardController {

    private static final Logger logger = LoggerFactory.getLogger(CardController.class);

    private SectionRepository sectionRepository;
    private CardRepository cardRepository;
    private LogService logService;

    public CardController(SectionRepository sectionRepository, CardRepository cardRepository, LogService logService) {
        this.sectionRepository = sectionRepository;
        this.cardRepository = cardRepository;
        this.logService = logService;
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

        // 섹션 내용 저장
        sectionRepository.save(section);
        newCard = cardRepository.findById(newCard.getId()).orElseThrow(ResourceNotFoundException::new);
        // 응답 객체 및 로그 생성
        Map<String, Object> responseData = logService.getResponseDataWithLog(Action.ADDED, (CardDTO) ModelMapper.of(newCard), section, loginUser);
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

        // 섹션 내용 저장
        CardDTO resultCard = (CardDTO) ModelMapper.of(section.updateCard(updateCard, body.get("title"), body.get("content")));
        sectionRepository.save(section);
        // 응답 객체 및 로그 생성
        Map<String, Object> responseData = logService.getResponseDataWithLog(Action.UPDATED, resultCard, section, loginUser);
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
        // 응답 객체 및 로그 생성
        Map<String, Object> responseData = logService.getResponseDataWithLog(Action.REMOVED, targetCard, section, loginUser);
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
            Map<String, Object> responseData = logService.getResponseDataWithLog(Action.MOVED, moveCard, section, loginUser);
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
        Map<String, Object> responseData = logService.getResponseDataWithLog(moveCard, fromSection, toSection, loginUser);
        return new ResponseEntity<>(new ResponseData(ResponseData.Status.SUCCESS, responseData), HttpStatus.OK);
    }
}
