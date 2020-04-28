package io.codesquad.group2.banchanservice.category;

import io.codesquad.group2.banchanservice.banchan.Banchan;
import lombok.Builder;
import lombok.Data;
import org.springframework.data.annotation.Id;

import java.util.Set;

@Data
@Builder
public class Category {

    private @Id String path;
    private String name;
    private String description;
    private Set<Banchan> banchans;

}
