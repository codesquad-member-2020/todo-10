package com.codesquad.team10.todo.api;

import com.auth0.jwt.exceptions.JWTDecodeException;
import com.auth0.jwt.exceptions.SignatureVerificationException;
import com.codesquad.team10.todo.entity.Section;
import com.codesquad.team10.todo.exception.custom.ForbiddenException;
import com.codesquad.team10.todo.exception.custom.InvalidTokenException;
import com.codesquad.team10.todo.exception.custom.UnauthorizedException;
import com.codesquad.team10.todo.exception.custom.UserNotFoundException;
import com.codesquad.team10.todo.repository.SectionRepository;
import com.codesquad.team10.todo.repository.UserRepository;
import com.codesquad.team10.todo.response.ResponseData;
import com.codesquad.team10.todo.entity.User;
import com.codesquad.team10.todo.constants.ResponseMessage;
import com.codesquad.team10.todo.util.JWTUtils;
import com.codesquad.team10.todo.util.ModelMapper;
import com.codesquad.team10.todo.dto.CardDTO;
import com.codesquad.team10.todo.dto.SectionDTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/board")
public class BoardController {

    private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

    private UserRepository userRepository;
    private SectionRepository sectionRepository;

    public BoardController(UserRepository userRepository, SectionRepository sectionRepository) {
        this.userRepository = userRepository;
        this.sectionRepository = sectionRepository;
    }

    @PostMapping("/login")
    public ResponseEntity<ResponseData> login(@RequestBody User loginUser, HttpServletResponse response) {
        User dbUser = userRepository.findByName(loginUser.getName()).orElseThrow(UserNotFoundException::new);
        if (!dbUser.confirmPassword(loginUser))
            throw new UnauthorizedException();

        logger.debug("board id: {}", dbUser.getBoard());

        String token = JWTUtils.createTokenByUser(dbUser);
        response.setHeader(HttpHeaders.AUTHORIZATION, token);
        return new ResponseEntity<>(new ResponseData(ResponseData.Status.SUCCESS, ResponseMessage.LOGIN_SUCCESS.getMessage()), HttpStatus.OK);
    }

    @GetMapping("")
    public ResponseEntity<ResponseData> show(HttpServletRequest request) {
        User userData = null;
        try {
            userData = JWTUtils.getUserFromJWT(request.getHeader(HttpHeaders.AUTHORIZATION));
        } catch (SignatureVerificationException | NullPointerException e) {
            throw new ForbiddenException();
        } catch (JWTDecodeException e) {
            throw new InvalidTokenException();
        }
        List<SectionDTO> sectionDTOS = new ArrayList<>();
        List<Section> sections = sectionRepository.findByBoardId(userData.getBoard());
        for (Section section : sections) {
            List<CardDTO> cards = section.getCards().stream()
                    .map(card -> (CardDTO)ModelMapper.of(card))
                    .collect(Collectors.toList());
            SectionDTO sectionDTO = (SectionDTO)ModelMapper.of(section);
            sectionDTOS.add(sectionDTO);
        }
        return new ResponseEntity<>(new ResponseData(ResponseData.Status.SUCCESS, sectionDTOS), HttpStatus.OK);
    }
}
