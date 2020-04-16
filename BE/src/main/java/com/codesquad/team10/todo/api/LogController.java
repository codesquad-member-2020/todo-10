package com.codesquad.team10.todo.api;

import com.auth0.jwt.exceptions.JWTDecodeException;
import com.auth0.jwt.exceptions.SignatureVerificationException;
import com.codesquad.team10.todo.entity.Log;
import com.codesquad.team10.todo.entity.User;
import com.codesquad.team10.todo.exception.custom.ForbiddenException;
import com.codesquad.team10.todo.exception.custom.InvalidTokenException;
import com.codesquad.team10.todo.exception.custom.ResourceNotFoundException;
import com.codesquad.team10.todo.repository.LogRepository;
import com.codesquad.team10.todo.response.ResponseData;
import com.codesquad.team10.todo.util.DateTimeFormatUtils;
import com.codesquad.team10.todo.util.JWTUtils;
import com.codesquad.team10.todo.util.ModelMapper;
import com.codesquad.team10.todo.dto.LogDTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/board")
public class LogController {

    private static final Logger logger = LoggerFactory.getLogger(LogController.class);

    private LogRepository logRepository;

    public LogController(LogRepository logRepository) {
        this.logRepository = logRepository;
    }

    @GetMapping("/logs")
    public ResponseEntity<ResponseData> showLogs(HttpServletRequest request) {
        User userData = null;
        try {
            userData = JWTUtils.getUserFromJWT(request.getHeader(HttpHeaders.AUTHORIZATION));
        } catch (SignatureVerificationException | NullPointerException e) {
            throw new ForbiddenException();
        } catch (JWTDecodeException e) {
            throw new InvalidTokenException();
        }
        List<LogDTO> logDTOs = logRepository.findByBoardId(userData.getBoard()).stream()
                .map(log -> (LogDTO) ModelMapper.of(log))
                .collect(Collectors.toList());
        return new ResponseEntity<>(new ResponseData(ResponseData.Status.SUCCESS, logDTOs), HttpStatus.OK);
    }

    @GetMapping("/log/{logId}")
    public ResponseEntity<ResponseData> showLog(@PathVariable int logId) {
        Log log = logRepository.findById(logId).orElseThrow(ResourceNotFoundException::new);
        return new ResponseEntity<>(new ResponseData(ResponseData.Status.SUCCESS, (LogDTO)ModelMapper.of(log)), HttpStatus.OK);
    }

    @GetMapping("/log/serverTime")
    public ResponseEntity<ResponseData> getServerTime() {
        return new ResponseEntity<>(new ResponseData(ResponseData.Status.SUCCESS, DateTimeFormatUtils.localDateTimeToString(LocalDateTime.now())), HttpStatus.OK);
    }
}
