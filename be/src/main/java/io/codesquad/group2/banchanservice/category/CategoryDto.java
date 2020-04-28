package io.codesquad.group2.banchanservice.category;

import io.codesquad.group2.banchanservice.banchan.BanchanSummaryDto;
import lombok.Builder;
import lombok.Value;

import java.util.Set;

@Value
@Builder
public class CategoryDto {

    String name;
    String description;
    Set<BanchanSummaryDto> banchan;

}
