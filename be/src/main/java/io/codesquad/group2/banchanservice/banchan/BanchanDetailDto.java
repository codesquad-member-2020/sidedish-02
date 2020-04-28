package io.codesquad.group2.banchanservice.banchan;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;
import lombok.Builder;
import lombok.Value;

import java.util.List;

@Value
@Builder
public class BanchanDetailDto {

    String id;
    String topImage;
    String alt;
    List<String> thumbImages;
    List<String> detailImages;
    String deliveryInfo;
    String deliveryFee;
    String title;
    String description;
    String point;
    @JsonInclude(Include.NON_NULL)
    String originalPrice;
    String finalPrice;

}
