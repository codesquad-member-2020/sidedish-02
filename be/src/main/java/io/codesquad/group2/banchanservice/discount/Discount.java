package io.codesquad.group2.banchanservice.discount;

import lombok.Builder;
import lombok.Data;
import org.springframework.data.annotation.Id;

@Data
@Builder
public class Discount {

    @Id private String name;
    private Double rate;
}
