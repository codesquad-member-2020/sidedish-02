package io.codesquad.group2.banchanservice.category;

import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class CategorySummaryDto {

    String name;
    String description;
    String path;

}
