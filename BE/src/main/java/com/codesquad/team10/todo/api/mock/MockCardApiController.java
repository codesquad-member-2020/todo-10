package com.codesquad.team10.todo.api.mock;

import com.codesquad.team10.todo.bean.ResponseData;
import com.codesquad.team10.todo.domain.Card;
import com.codesquad.team10.todo.domain.Route;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.Map;

@RestController
@RequestMapping("/mock/section/{sectionId}/card")
public class MockCardApiController {

    private static final Logger log = LoggerFactory.getLogger(MockCardApiController.class);
    private static long seq = 0;

    @PostMapping("")
    public ResponseEntity<ResponseData> create(@PathVariable long sectionId, @RequestBody Card card) {

        log.debug("sectionId: {}, card: {}", sectionId, card);

        card.setId(++seq);
        card.setCreatedDateTime(LocalDateTime.now());
        card.setUpdatedDateTime(LocalDateTime.now());
        return new ResponseEntity<>(new ResponseData(ResponseData.Status.SUCCESS, card), HttpStatus.OK);
    }
}
