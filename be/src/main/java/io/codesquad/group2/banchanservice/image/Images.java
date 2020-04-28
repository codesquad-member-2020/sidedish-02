package io.codesquad.group2.banchanservice.image;

import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class Images {

    private String summaryImage;
    private String topImage;
    private List<String> thumbImages;
    private List<String> detailImages;

    public void addThumbImage(String thumbImageUrl) {
        thumbImages.add(thumbImageUrl);
    }

    public void addDetailImage(String detailImageUrl) {
        detailImages.add(detailImageUrl);
    }

}
