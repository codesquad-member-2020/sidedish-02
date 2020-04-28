package io.codesquad.group2.banchanservice.banchan;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;
import lombok.Builder;
import lombok.Value;

import java.util.Set;

@Value
@Builder
public class BanchanSummaryDto {

    String id;
    String image;
    String alt;
    Set<String> deliveryTypes;
    String title;
    String description;
    @JsonInclude(Include.NON_NULL)
    String originalPrice;
    String finalPrice;
    @JsonInclude(Include.NON_EMPTY)
    Set<String> badges;

}
