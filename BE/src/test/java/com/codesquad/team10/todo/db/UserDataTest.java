package com.codesquad.team10.todo.db;

import com.codesquad.team10.todo.domain.User;
import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.Optional;
import com.codesquad.team10.todo.repository.UserRepository;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest
public class UserDataTest {

    private static final Logger log = LoggerFactory.getLogger(UserDataTest.class);
    @Autowired
    private UserRepository userRepository;

    @Test
    public void getUser() {
        Optional<User> user = userRepository.findByEmail("nigayo@ggmail.com");
        assertThat(user).isNotNull();
        log.debug("user data : {}", user);
    }
}
