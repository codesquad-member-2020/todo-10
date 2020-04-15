package com.codesquad.team10.todo.repository;

import com.codesquad.team10.todo.entity.Log;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface LogRepository extends CrudRepository<Log, Integer> {

    @Query("SELECT *" +
            " FROM log l" +
            " WHERE l.board = :boardId")
    List<Log> findByBoardId(Integer boardId);
}
