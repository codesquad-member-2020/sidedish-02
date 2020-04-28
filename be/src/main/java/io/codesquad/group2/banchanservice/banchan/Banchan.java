package io.codesquad.group2.banchanservice.banchan;

import io.codesquad.group2.banchanservice.delivery.Delivery;
import io.codesquad.group2.banchanservice.discount.Discount;
import io.codesquad.group2.banchanservice.image.Images;
import lombok.Builder;
import lombok.Data;
import org.springframework.data.annotation.Id;

import java.util.Set;

@Data
@Builder
public class Banchan {

    @Id private String id;
    private String title;
    private String description;
    // @JsonSerialize(using = PriceSerializer.class)
    private int price;
    private Set<Delivery> deliveries;
    private Set<Discount> discounts;
    private Images images;

    public void addDelivery(Delivery delivery) {
        deliveries.add(delivery);
    }

    public void addDiscount(Discount discount) {
        discounts.add(discount);
    }

}
