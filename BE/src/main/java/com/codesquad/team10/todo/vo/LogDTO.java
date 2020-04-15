package com.codesquad.team10.todo.vo;

import com.codesquad.team10.todo.entity.Action;
import com.codesquad.team10.todo.entity.Target;
import com.codesquad.team10.todo.util.DateTimeFormatUtils;

import java.time.LocalDateTime;

public class LogDTO {

    private Integer id;

    private String user;

    private Action action;

    private Target target;

    private String title;

    private String content;

    private String source;

    private String destination;

    private LocalDateTime createDateTime;

    private Integer board;

    public LogDTO(Integer id, String user, Action action, Target target, String title, String content, String source, String destination, LocalDateTime createDateTime, Integer board) {
        this.id = id;
        this.user = user;
        this.action = action;
        this.target = target;
        this.title = title;
        this.content = content;
        this.source = source;
        this.destination = destination;
        this.createDateTime = createDateTime;
        this.board = board;
    }

    public Integer getId() {
        return id;
    }

    public String getUser() {
        return user;
    }

    public Action getAction() {
        return action;
    }

    public Target getTarget() {
        return target;
    }

    public String getTitle() {
        return title;
    }

    public String getContent() {
        return content;
    }

    public String getSource() {
        return source;
    }

    public String getDestination() {
        return destination;
    }

    public String getCreateDateTime() {
        return DateTimeFormatUtils.localDateTimeToString(createDateTime);
    }
}
