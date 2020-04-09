package com.codesquad.team10.todo.repository;

import com.codesquad.team10.todo.domain.User;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.Optional;

public interface UserRepository extends CrudRepository<User, Long> {

    @Query("select * from user where email = :email")
    Optional<User> findByEmail(String email);
}
