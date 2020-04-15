package com.codesquad.team10.todo.repository;

import com.codesquad.team10.todo.entity.Card;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.Optional;

public interface CardRepository extends CrudRepository<Card, Integer> {
    @Query("SELECT *" +
            " FROM card c" +
            " LEFT OUTER JOIN section s ON c.section = s.id" +
            " WHERE c.id = :id")
    Optional<Card> findById(Integer id);
}
