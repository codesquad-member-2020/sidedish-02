package io.codesquad.group2.banchanservice.banchan;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class BanchanController {

    private final BanchanService banchanService;

    public BanchanController(BanchanService banchanService) {
        this.banchanService = banchanService;
    }

    @GetMapping("/banchan/{id}")
    public ResponseEntity<BanchanDetailDto> getBanchanDetail(@PathVariable String id) {
        return ResponseEntity.ok(banchanService.getDetailDtoById(id));
    }

}
