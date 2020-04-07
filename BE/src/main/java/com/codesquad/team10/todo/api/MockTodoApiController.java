package com.codesquad.team10.todo.api;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/mock")
public class MockTodoApiController {

    private static final Logger log = LoggerFactory.getLogger(MockTodoApiController.class);

    @PostMapping("/login")
    public JsonNode login(@RequestBody(required = false) String email, @RequestBody(required = false) String password) {
        // 인증 과정은 추후에 구현해야함

        log.debug("email: {}, password: {}", email, password);

        JsonNode node = null;
        try {
            String response = "{" +
                    "    \"columns\": [" +
                    "        {" +
                    "            \"id\": \"1\"," +
                    "            \"title\": \"해야 할 일\"," +
                    "            \"cards\": [" +
                    "                { \"id\": \"2\", \"content\": \"내용2 출력됩니다.\" }," +
                    "                { \"id\": \"1\", \"content\": \"내용1 출력됩니다.\" }" +
                    "            ]" +
                    "        }," +
                    "        {" +
                    "            \"id\": \"2\"," +
                    "            \"title\": \"하고 있는 일\"," +
                    "            \"cards\": [" +
                    "                { \"id\": \"3\", \"title\": \"제목1\", \"content\": \"내용3 출력됩니다.\" }," +
                    "                { \"id\": \"4\", \"title\": null, \"content\": \"내용5 출력됩니다.\" }," +
                    "                { \"id\": \"3\", \"title\": \"제목3\", \"content\": \"내용6 출력됩니다.\"}," +
                    "                { \"id\": \"4\", \"title\": null, \"content\": \"내용4 출력됩니다.\" }," +
                    "                { \"id\": \"3\", \"title\": null, \"content\": \"내용3 출력됩니다.\" }" +
                    "            ]" +
                    "        }," +
                    "        {" +
                    "            \"id\": \"3\"," +
                    "            \"title\": \"완료 된 일\"," +
                    "            \"cards\": [" +
                    "                { \"id\": \"5\", \"title\": \"제목9\", \"content\": \"내용5 출력됩니다.\" }," +
                    "                { \"id\": \"6\", \"title\": null, \"content\": \"내용1 출력됩니다.\" }" +
                    "            ]" +
                    "        }" +
                    "    ]," +
                    "    \"logs\": [" +
                    "        { " +
                    "            \"action\": \"moved\"," +
                    "            \"card\": \"github 공부하기\"," +
                    "            \"source\": \"해야 할 일\"," +
                    "            \"destination\": \"완료 된 일\"," +
                    "            \"createdDateTime\": \"2020-03-02\"" +
                    "        }," +
                    "        {" +
                    "            \"action\": \"updated\"," +
                    "            \"card\": \"스켈레톤 작성\"," +
                    "            \"source\": null," +
                    "            \"destination\": null," +
                    "            \"createdDateTime\": \"2020-03-05\"" +
                    "        }," +
                    "        {" +
                    "            \"action\": \"added\"," +
                    "            \"card\": \"데모 환경 구성\"," +
                    "            \"source\": null,\n" +
                    "            \"destination\": \"하고 있는 일\"," +
                    "            \"createdDateTime\": \"2020-04-11\"" +
                    "        }," +
                    "        {" +
                    "            \"action\": \"removed\"," +
                    "            \"card\": \"README.md 수\"," +
                    "            \"source\": \"해야 할 일\"," +
                    "            \"destination\": null," +
                    "            \"createdDateTime\": \"2020-03-24\"" +
                    "        }" +
                    "    ]" +
                    "}";
            ObjectMapper mapper = new ObjectMapper();
            node = mapper.readTree(response);
            log.debug("login response: {}", node);

        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        return node;
    }
}
