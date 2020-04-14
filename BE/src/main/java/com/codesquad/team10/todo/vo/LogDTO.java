package com.codesquad.team10.todo.vo;

import com.codesquad.team10.todo.entity.Action;
import com.codesquad.team10.todo.entity.Target;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;

public class LogDTO {

    private Integer id;

    private String user;

    private Action action;

    private Target target;

    private String content;

    private String source;

    private String destination;

    private long minutesUntilNow;

    private Integer board;

    public LogDTO(Integer id, String user, Action action, Target target, String content, String source, String destination, LocalDateTime createDateTime, Integer board) {
        this.id = id;
        this.user = user;
        this.action = action;
        this.target = target;
        this.content = content;
        this.source = source;
        this.destination = destination;
        this.minutesUntilNow = createDateTime.until(LocalDateTime.now(), ChronoUnit.MINUTES);
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

    public String getContent() {
        return content;
    }

    public String getSource() {
        return source;
    }

    public String getDestination() {
        return destination;
    }

    public long getMinutesUntilNow() {
        return minutesUntilNow;
    }
}
