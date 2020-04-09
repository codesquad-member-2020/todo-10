package com.codesquad.team10.todo.domain;

import com.codesquad.team10.todo.exception.ResourceNotFoundException;
import com.fasterxml.jackson.databind.JsonNode;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Objects;

public class User {

    private int id;
    private String email;
    private String password;
    private List<Section> sections = new LinkedList<>();
    private List<Log> logs = new ArrayList<>();

    public User(int id, String email, String password) {
        this.id = id;
        this.email = email;
        this.password = password;
    }

    public int getId() {
        return id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public List<Section> getSections() {
        return sections;
    }

    public Section getSection(int sectionId) {
        for (Section section : sections) {
            if (section.getId() == sectionId)
                return section;
        }
        throw new ResourceNotFoundException();
    }

    public List<Log> getLogs() {
        return logs;
    }

    public void addSection(Section newSection) {
        sections.add(newSection);
    }

    public void addCard(int sectionId, Card newCard) {
        sections.get(sectionId).addCard(newCard);
    }

    public Card updateCard(int sectionId, Card updatedCard) {
        return sections.get(sectionId).updateCard(updatedCard);
    }

    public boolean deleteCard(int sectionId, int cardId) {
        return sections.get(sectionId).deleteCard(cardId);
    }

   @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", email='" + email + '\'' +
                ", password='" + password + '\'' +
                ", sections=" + sections +
                ", logs=" + logs +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        User user = (User) o;
        return id == user.id &&
                email.equals(user.email);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, email);
    }
}
