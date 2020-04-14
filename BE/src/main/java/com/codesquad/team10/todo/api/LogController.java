package com.codesquad.team10.todo.api;

import com.codesquad.team10.todo.repository.LogRepository;
import com.codesquad.team10.todo.response.ResponseData;
import com.codesquad.team10.todo.util.ModelMapper;
import com.codesquad.team10.todo.vo.LogDTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/board")
public class LogController {

    private static final Logger logger = LoggerFactory.getLogger(LogController.class);
    private static final Integer TEST_BOARD_ID = 1;

    private LogRepository logRepository;

    public LogController(LogRepository logRepository) {
        this.logRepository = logRepository;
    }

    @GetMapping("/logs")
    public ResponseEntity<ResponseData> showLogs() {
        List<LogDTO> logDTOs = logRepository.findByBoardId(TEST_BOARD_ID).stream()
                .map(log -> (LogDTO) ModelMapper.of(log))
                .collect(Collectors.toList());
        return new ResponseEntity<>(new ResponseData(ResponseData.Status.SUCCESS, logDTOs), HttpStatus.OK);
    }
}
