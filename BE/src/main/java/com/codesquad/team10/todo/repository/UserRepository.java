package com.codesquad.team10.todo.repository;

import com.codesquad.team10.todo.entity.User;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.Optional;

public interface UserRepository extends CrudRepository<User, Integer> {

    @Query("SELECT id, name, password, board, board_key" +
            " FROM user" +
            " WHERE name = :name")
    Optional<User> findByName(String name);
}
