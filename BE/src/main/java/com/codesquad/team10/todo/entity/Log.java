package com.codesquad.team10.todo.entity;

import org.springframework.data.annotation.Id;

import java.time.LocalDateTime;

public class Log {

    @Id
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

    public Log() {
    }

    public Log(String user, Action action, Target target, String title, String content, String source, String destination, Integer board) {
        this.user = user;
        this.action = action;
        this.target = target;
        this.title = title;
        this.content = content;
        this.source = source;
        this.destination = destination;
        this.board = board;
    }

    public Log(Integer id, String user, Action action, Target target, String title, String content, String source, String destination, LocalDateTime createDateTime, Integer board) {
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

    public LocalDateTime getCreateDateTime() {
        return createDateTime;
    }

    public Integer getBoard() {
        return board;
    }

    @Override
    public String toString() {
        return "Log{" +
                "id=" + id +
                ", user='" + user + '\'' +
                ", action=" + action +
                ", target=" + target +
                ", content='" + content + '\'' +
                ", source='" + source + '\'' +
                ", destination='" + destination + '\'' +
                ", createDateTime=" + createDateTime +
                ", board=" + board +
                '}';
    }
}
