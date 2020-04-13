package com.codesquad.team10.todo;

import com.codesquad.team10.todo.entity.Card;
import com.codesquad.team10.todo.entity.Section;
import com.codesquad.team10.todo.vo.BoardVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class BoardDAO {

    private JdbcTemplate jdbcTemplate;

    @Autowired
    public void setDataSource(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    public BoardVO getBoard(List<Section> sections) {
//        List<Section> sections = this.jdbcTemplate.query(
//                "SELECT s.id AS section_id, s.title AS section_title, s.create_date_time AS section_create_date_time, s.update_date_time AS section_update_date_time FROM board b LEFT OUTER JOIN section s ON b.id = s.board",
//                new RowMapper<Section>() {
//                    public Section mapRow(ResultSet rs, int rowNum) throws SQLException {
//                        Section section = new Section();
//                        section.setId(rs.getInt("s.id"));
//                        section.setTitle(rs.getString("s.title"));
//                        section.setCreateDateTime(rs.getTimestamp("s.create_date_time").toLocalDateTime());
//                        section.setUpdateDateTime(rs.getTimestamp("s.update_date_time").toLocalDateTime());
//                        return section;
//                    }
//                });

        for (Section section : sections) {
            String sql = "SELECT c.id AS card_id, c.title AS card_title, c.content AS card_content, c.create_date_time AS card_create_date_time, c.update_date_time AS card_update_date_time, (SELECT u.email FROM user u WHERE c.user = u.id) AS user_email FROM section s LEFT OUTER JOIN card c ON c.section = s.id WHERE s.id = ?";
            RowMapper<Card> mapper = new RowMapper<Card>() {
                @Override
                public Card mapRow(ResultSet rs, int rowNum) throws SQLException {
                    Card card = new Card(
                                rs.getInt("card_id"),
                                rs.getString("card_title"),
                                rs.getString("card_content"),
                                rs.getTimestamp("card_create_date_time").toLocalDateTime(),
                                rs.getTimestamp("card_update_date_time").toLocalDateTime()
                        );
                    card.setUserEmail(rs.getString("user_email"));
                        return card;
                }
            };
            List<Card> cards = this.jdbcTemplate.query(sql, mapper, section.getId());
            section.setCards(cards);
        }
        return new BoardVO(sections, null);
    }
}
