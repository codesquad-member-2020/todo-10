package com.codesquad.team10.todo.api;

import com.codesquad.team10.todo.entity.Section;
import com.codesquad.team10.todo.repository.SectionRepository;
import com.codesquad.team10.todo.response.ResponseData;
import com.codesquad.team10.todo.entity.User;
import com.codesquad.team10.todo.constants.ResponseMessage;
import com.codesquad.team10.todo.service.AuthService;
import com.codesquad.team10.todo.util.ModelMapper;
import com.codesquad.team10.todo.dto.SectionDTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/board")
public class BoardController {

    private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

    private AuthService authService;
    private SectionRepository sectionRepository;

    public BoardController(AuthService authService, SectionRepository sectionRepository) {
        this.authService = authService;
        this.sectionRepository = sectionRepository;
    }

    @PostMapping("/login")
    public ResponseEntity<ResponseData> login(@RequestBody User loginUser,
                                              HttpServletResponse response) {
        if (authService.verifyUser(loginUser, response))
            return new ResponseEntity<>(new ResponseData(ResponseData.Status.SUCCESS, ResponseMessage.LOGIN_SUCCESS.getMessage()), HttpStatus.OK);

        // 비밀번호 틀린 경우
        return new ResponseEntity<>(new ResponseData(ResponseData.Status.ERROR, ResponseMessage.LOGIN_FAILED.getMessage()), HttpStatus.UNAUTHORIZED);
    }

    @GetMapping("")
    public ResponseEntity<ResponseData> show(HttpServletRequest request) {
        User loginUser = (User)request.getAttribute("user");
        List<SectionDTO> sectionDTOS = new ArrayList<>();
        List<Section> sections = sectionRepository.findByBoardId(loginUser.getBoard());
        for (Section section : sections) {
            SectionDTO sectionDTO = (SectionDTO)ModelMapper.of(section);
            sectionDTOS.add(sectionDTO);
        }
        return new ResponseEntity<>(new ResponseData(ResponseData.Status.SUCCESS, sectionDTOS), HttpStatus.OK);
    }
}
