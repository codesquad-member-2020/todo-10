package com.codesquad.team10.todo.api;

import com.codesquad.team10.todo.repository.UserRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class KanbanBoardController {

    private static final Logger log = LoggerFactory.getLogger(KanbanBoardController.class);

    @Autowired
    private UserRepository userRepository;
}
