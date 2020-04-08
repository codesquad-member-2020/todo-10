package com.codesquad.team10.todo.api.mock;

import com.codesquad.team10.todo.bean.ResponseData;
import com.codesquad.team10.todo.domain.Log;
import com.codesquad.team10.todo.domain.Section;
import com.codesquad.team10.todo.domain.User;
import com.codesquad.team10.todo.exception.UserNotFoundException;
import com.codesquad.team10.todo.repository.MockUserRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@RestController
@RequestMapping("/mock")
public class MockUserApiController {

    private static final Logger log = LoggerFactory.getLogger(MockUserApiController.class);

    @Autowired
    private MockUserRepository mockUserRepository;
    private static long seq = 0;

    @PostMapping("/login")
    public ResponseEntity<ResponseData> login(@RequestBody User loginUser) {
        // 인증 과정은 추후에 구현해야함
        log.debug("login User: {}", loginUser);

        User dbUser = mockUserRepository.findByEmail().orElseThrow(UserNotFoundException::new);
        Map<String, Object> todoInfo = new HashMap<>();
        List<Section> sections = dbUser.getSections();
        List<Log> logs = dbUser.getLogs();
        todoInfo.put("sections",sections );
        todoInfo.put("logs", logs);

        log.debug("sections: {}, logs: {}", sections, logs);

        return new ResponseEntity<>(new ResponseData(ResponseData.Status.SUCCESS, todoInfo), HttpStatus.OK);
    }

    @ExceptionHandler(UserNotFoundException.class)
    public ResponseData handleUserNotFoundException(UserNotFoundException e) {
        return new ResponseData(ResponseData.Status.ERROR, e.getMessage());
    }
}
