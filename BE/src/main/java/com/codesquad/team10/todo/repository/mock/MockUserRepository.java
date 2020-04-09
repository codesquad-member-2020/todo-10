package com.codesquad.team10.todo.repository.mock;

import com.codesquad.team10.todo.domain.Section;
import com.codesquad.team10.todo.domain.User;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

@Component
public class MockUserRepository {

    private static Map<String, User> users = new HashMap<>();

    public MockUserRepository() {
//        User user = new User(1, "nigayo@ggmail.com", "1234");
//        user.addSection(new Section(0, "해야 할 일"));
//        user.addSection(new Section(1, "하고 있는 일"));
//        user.addSection(new Section(2, "완료한 일"));
//        users.put(user.getEmail(), user);
    }

    public Optional<User> findByEmail() {
        return Optional.ofNullable(users.get("nigayo@ggmail.com"));
    }

    public void save(User user) {
        users.put(user.getEmail(), user);
    }
}
