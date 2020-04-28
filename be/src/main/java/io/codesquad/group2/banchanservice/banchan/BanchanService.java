package io.codesquad.group2.banchanservice.banchan;

import io.codesquad.group2.banchanservice.delivery.Delivery;
import io.codesquad.group2.banchanservice.delivery.DeliveryDao;
import io.codesquad.group2.banchanservice.discount.Discount;
import io.codesquad.group2.banchanservice.discount.DiscountDao;
import io.codesquad.group2.banchanservice.image.ImageDao;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.List;
import java.util.Set;
import java.util.StringJoiner;
import java.util.stream.Collectors;

@Service
public class BanchanService {

    private static final Logger logger = LoggerFactory.getLogger(BanchanService.class);

    private final BanchanDao banchanDao;
    private final ImageDao imageDao;
    private final DeliveryDao deliveryDao;
    private final DiscountDao discountDao;

    public BanchanService(BanchanDao banchanDao, ImageDao imageDao, DeliveryDao deliveryDao, DiscountDao discountDao) {
        this.banchanDao = banchanDao;
        this.imageDao = imageDao;
        this.deliveryDao = deliveryDao;
        this.discountDao = discountDao;
    }

    public BanchanDetailDto getDetailDtoById(String id) {
        return mapToDetailDto(findById(id));
    }

    public Set<Banchan> getBanchanByCategory(String path) {
        List<String> banchanIdsInCategory = banchanDao.findBanchanIdsByCategory(path);
        return banchanIdsInCategory.stream()
                                   .map(this::findById)
                                   .collect(Collectors.toSet());
    }

    public BanchanSummaryDto mapToSummaryDto(Banchan banchan) {
        int originalPrice = banchan.getPrice();
        int finalPrice = originalPrice;
        Set<Discount> discounts = banchan.getDiscounts();
        if (discounts != null) {
            for (Discount discount : banchan.getDiscounts()) {
                finalPrice *= (1.0 - discount.getRate());
            }
        }
        NumberFormat format1 = new DecimalFormat("#,###원");
        NumberFormat format2 = new DecimalFormat("#,###");
        return BanchanSummaryDto.builder()
                                .id(banchan.getId())
                                .image(banchan.getImages().getSummaryImage())
                                .alt(banchan.getTitle())
                                .deliveryTypes(banchan.getDeliveries().stream().map(Delivery::getName).collect( Collectors.toSet()))
                                .title(banchan.getTitle())
                                .description(banchan.getDescription())
                                .originalPrice(originalPrice == finalPrice ? null : format2.format(originalPrice))
                                .finalPrice(format1.format(finalPrice))
                                .badges(banchan.getDiscounts().stream().map(Discount::getName).collect(Collectors.toSet()))
                                .build();
    }

    private Banchan findById(String id) {
        Banchan banchan = banchanDao.findById(id);
        banchan.setImages(imageDao.findImagesByBanchanId(id));
        banchan.setDeliveries(deliveryDao.findDeliveriesByBanchanId(id));
        banchan.setDiscounts(discountDao.findDiscountsByBanchanId(id));
        return banchan;
    }

    private BanchanDetailDto mapToDetailDto(Banchan banchan) {
        int originalPrice = banchan.getPrice();
        int finalPrice = originalPrice;
        for (Discount discount : banchan.getDiscounts()) {
            finalPrice *= (1.0 - discount.getRate());
        }
        StringJoiner deliveryInfoJoiner = new StringJoiner(" / ");
        banchan.getDeliveries()
               .stream()
               .map(Delivery::getInfo)
               .forEach(deliveryInfoJoiner::add);
        String deliveryInfo = deliveryInfoJoiner.toString();
        NumberFormat format1 = new DecimalFormat("#,###원");
        NumberFormat format2 = new DecimalFormat("#,###");
        return BanchanDetailDto.builder()
                               .id(banchan.getId())
                               .topImage(banchan.getImages().getTopImage())
                               .alt(banchan.getTitle())
                               .thumbImages(banchan.getImages().getThumbImages())
                               .detailImages(banchan.getImages().getDetailImages())
                               .deliveryInfo(deliveryInfo)
                               .deliveryFee(banchan.getDeliveries().iterator().next().getFee())
                               .title(banchan.getTitle())
                               .description(banchan.getDescription())
                               .point(format1.format(finalPrice / 100))
                               .originalPrice(originalPrice == finalPrice ? null : format1.format(originalPrice))
                               .finalPrice(format1.format(finalPrice))
                               .build();
    }

}
