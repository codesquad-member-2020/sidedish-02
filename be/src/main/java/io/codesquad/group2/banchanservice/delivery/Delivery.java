package io.codesquad.group2.banchanservice.delivery;

import lombok.Builder;
import lombok.Data;
import org.springframework.data.annotation.Id;

@Data
@Builder
public class Delivery {

    @Id private String name;
    private String info;
    private String fee;
}
