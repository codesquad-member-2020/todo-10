package com.codesquad.team10.todo.service;

import com.codesquad.team10.todo.domain.Card;
import com.codesquad.team10.todo.domain.User;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class CardServiceImpl implements CardService {
    @Override
    public List<JsonNode> getCardOder(User user, int sectionId, int cardId) throws JsonProcessingException {
        ObjectMapper mapper = new ObjectMapper();
        List<JsonNode> orders = new ArrayList<>();
        List<Card> cards = user.getSection(sectionId).getCards();
        for (Card card : cards) {
            orders.add(mapper.readTree("{ \"id\": \"" + card.getId() + "\" }"));
        }
        return orders;
    }
}
