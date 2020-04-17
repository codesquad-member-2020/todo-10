package com.codesquad.team10.todo.api;

import com.codesquad.team10.todo.dto.SectionDTO;
import com.codesquad.team10.todo.entity.Action;
import com.codesquad.team10.todo.entity.Section;
import com.codesquad.team10.todo.entity.User;
import com.codesquad.team10.todo.exception.custom.ResourceNotFoundException;
import com.codesquad.team10.todo.repository.SectionRepository;
import com.codesquad.team10.todo.response.ResponseData;
import com.codesquad.team10.todo.service.LogService;
import com.codesquad.team10.todo.util.ModelMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

@RestController
@RequestMapping("/board/section")
public class SectionController {
    
    private static final Logger logger = LoggerFactory.getLogger(SectionController.class);
    
    private SectionRepository sectionRepository;
    private LogService logService;

    public SectionController(SectionRepository sectionRepository, LogService logService) {
        this.sectionRepository = sectionRepository;
        this.logService = logService;
    }

    @PostMapping("")
    public ResponseEntity<ResponseData> create(@RequestBody Map<String, String> body,
                                               HttpServletRequest request) {

        String title = body.get("title");

        logger.debug("section title: {}", title);

        User loginUser = (User)request.getAttribute("user");
        Section section = new Section(title, loginUser.getBoard());
        sectionRepository.save(section);
        SectionDTO sectionDTO = (SectionDTO) ModelMapper.of(sectionRepository.findById(section.getId()).orElseThrow(ResourceNotFoundException::new));
        Map<String, Object> responseData = logService.getResponseDataWithLog(Action.ADDED, sectionDTO, loginUser);
        return new ResponseEntity<>(new ResponseData(ResponseData.Status.SUCCESS, responseData), HttpStatus.OK);
    }
}
