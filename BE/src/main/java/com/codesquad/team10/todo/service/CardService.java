package com.codesquad.team10.todo.service;

import com.codesquad.team10.todo.domain.User;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;

import java.util.List;

public interface CardService {
    public List<JsonNode> getCardOder(User user, int sectionId, int cardId) throws JsonProcessingException;
}
