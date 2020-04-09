package com.codesquad.team10.todo.api.mock;

import com.codesquad.team10.todo.bean.ResponseData;
import com.codesquad.team10.todo.domain.Card;
import com.codesquad.team10.todo.domain.User;
import com.codesquad.team10.todo.exception.ResourceNotFoundException;
import com.codesquad.team10.todo.exception.UserNotFoundException;
import com.codesquad.team10.todo.repository.mock.MockUserRepository;
import com.fasterxml.jackson.core.JsonProcessingException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;

@RestController
@RequestMapping("/mock/section/{sectionId}/card")
public class MockCardController {

    private static final Logger log = LoggerFactory.getLogger(MockCardController.class);

    @Autowired
    private MockUserRepository mockUserRepository;
    private static int seq = 0;

    @PostMapping("")
    public ResponseEntity<ResponseData> create(@PathVariable int sectionId, @RequestBody Card card) {
        log.debug("sectionId: {}, card: {}", sectionId, card);

        User dbUser = mockUserRepository.findByEmail().orElseThrow(UserNotFoundException::new);
        try {
            dbUser.addCard(sectionId, card);
            card.setId(seq++);
            card.setCreatedDateTime(LocalDateTime.now());
            card.setUpdatedDateTime(LocalDateTime.now());
        } catch (IndexOutOfBoundsException e) {
            throw new ResourceNotFoundException();
        }
        return new ResponseEntity<>(new ResponseData(ResponseData.Status.SUCCESS, card), HttpStatus.OK);
    }

    @PatchMapping("/{id}")
    public ResponseEntity<ResponseData> update(@PathVariable int sectionId, @PathVariable int id, @RequestBody Card updatedCard) {

        updatedCard.setId(id);
        log.debug("sectionId: {}, card id: {}, title: {}, content: {}", sectionId, updatedCard.getId(), updatedCard.getTitle(), updatedCard.getContent());

        User dbUser = mockUserRepository.findByEmail().orElseThrow(UserNotFoundException::new);
        try {
            updatedCard = dbUser.updateCard(sectionId, updatedCard);
        } catch (IndexOutOfBoundsException e) {
            throw new ResourceNotFoundException();
        }
        return new ResponseEntity<>(new ResponseData(ResponseData.Status.SUCCESS, updatedCard), HttpStatus.OK);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<ResponseData> delete(@PathVariable int sectionId, @PathVariable int id) throws JsonProcessingException {
        User dbUser = mockUserRepository.findByEmail().orElseThrow(UserNotFoundException::new);
        try {
            if(!dbUser.deleteCard(sectionId, id))
                throw new ResourceNotFoundException();
        } catch (IndexOutOfBoundsException e) {
            throw new ResourceNotFoundException();
        }
        return new ResponseEntity<>(new ResponseData(ResponseData.Status.SUCCESS, "Card is Successfully Deleted"), HttpStatus.OK);
    }

    @ExceptionHandler(ResourceNotFoundException.class)
    public ResponseData handleResourceNotFoundException(ResourceNotFoundException e) {
        return new ResponseData(ResponseData.Status.ERROR, e.getMessage());
    }
}
