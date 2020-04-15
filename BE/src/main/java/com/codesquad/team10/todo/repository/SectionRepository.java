package com.codesquad.team10.todo.repository;

import com.codesquad.team10.todo.entity.Section;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface SectionRepository extends CrudRepository<Section, Integer> {

    @Query("SELECT *" +
            " FROM section s" +
            " LEFT OUTER JOIN board b ON s.board = b.id")
    List<Section> findByBoardId(Integer boardId);
}
