package com.codesquad.team10.todo.api;

import com.codesquad.team10.todo.entity.Card;
import com.codesquad.team10.todo.entity.Section;
import com.codesquad.team10.todo.exception.custom.UserNotFoundException;
import com.codesquad.team10.todo.repository.SectionRepository;
import com.codesquad.team10.todo.response.ResponseData;
import com.codesquad.team10.todo.entity.User;
import com.codesquad.team10.todo.repository.BoardRepository;
import com.codesquad.team10.todo.constants.ResponseMessage;
import com.codesquad.team10.todo.util.ModelMapper;
import com.codesquad.team10.todo.vo.CardDTO;
import com.codesquad.team10.todo.vo.SectionDTO;
import com.sun.org.apache.xpath.internal.operations.Mod;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/board")
public class BoardController {

    private static final Logger log = LoggerFactory.getLogger(BoardController.class);
    private static final Integer TEST_BOARD_ID = 1;
    private static final String TEST_USER_NAME = "nigayo";

    private BoardRepository boardRepository;
    private SectionRepository sectionRepository;

    public BoardController(BoardRepository boardRepository, SectionRepository sectionRepository) {
        this.boardRepository = boardRepository;
        this.sectionRepository = sectionRepository;
    }

    @PostMapping("/login")
    public ResponseEntity<ResponseData> login(@RequestBody User loginUser) {
        // 하드 코딩 유저
        // 이후 jwt 적용할 예정
        int count = boardRepository.countByUserName(loginUser.getName());

        log.debug("count: {}", count);

        if (count > 0)
            return new ResponseEntity<>(new ResponseData(ResponseData.Status.SUCCESS, ResponseMessage.LOGIN_SUCCESS.getMessage()), HttpStatus.OK);

        throw new UserNotFoundException();
    }

    @GetMapping("")
    public ResponseEntity<ResponseData> show() {
        List<SectionDTO> sectionDTOS = new ArrayList<>();
        List<Section> sections = sectionRepository.findByBoardId(TEST_BOARD_ID).stream()
                .filter(section -> !section.isDeleted())
                .collect(Collectors.toList());
        for (Section section : sections) {
            List<CardDTO> cards = section.getCards().stream()
                    .filter(card -> !card.isDeleted())
                    .map(card -> (CardDTO)ModelMapper.of(card))
                    .collect(Collectors.toList());
            SectionDTO sectionDTO = (SectionDTO)ModelMapper.of(section);
            sectionDTO.setCards(cards);
            sectionDTOS.add(sectionDTO);
        }
        return new ResponseEntity<>(new ResponseData(ResponseData.Status.SUCCESS, sectionDTOS), HttpStatus.OK);
    }
}
