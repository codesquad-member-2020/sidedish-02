package io.codesquad.group2.banchanservice.init;

import com.fasterxml.jackson.core.JsonProcessingException;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class DbInitController {

    private final DbInitService dbInitService;

    public DbInitController(DbInitService dbInitService) {
        this.dbInitService = dbInitService;
    }

    @GetMapping("/init-db")
    public String initDb() throws JsonProcessingException {
        dbInitService.initDb();
        return "done";
    }

}
