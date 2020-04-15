package com.codesquad.team10.todo.repository;

import com.codesquad.team10.todo.entity.Board;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;

public interface BoardRepository extends CrudRepository<Board, Integer> {

    @Query("SELECT COUNT(u.name) FROM board b" +
            " LEFT OUTER JOIN user u ON b.id = u.board" +
            " WHERE u.name = :name")
    Integer countByUserName(String name);
}
