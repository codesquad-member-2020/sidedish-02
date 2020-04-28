package io.codesquad.group2.banchanservice.init;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.codesquad.group2.banchanservice.banchan.Banchan;
import io.codesquad.group2.banchanservice.banchan.BanchanDao;
import io.codesquad.group2.banchanservice.category.Category;
import io.codesquad.group2.banchanservice.category.CategoryDao;
import io.codesquad.group2.banchanservice.delivery.Delivery;
import io.codesquad.group2.banchanservice.delivery.DeliveryDao;
import io.codesquad.group2.banchanservice.discount.Discount;
import io.codesquad.group2.banchanservice.discount.DiscountDao;
import io.codesquad.group2.banchanservice.image.ImageDao;
import io.codesquad.group2.banchanservice.image.Images;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.StringJoiner;

@Service
public class DbInitService {

    private static final Logger logger = LoggerFactory.getLogger(DbInitService.class);
    private static final RestTemplate restTemplate = new RestTemplate();
    private static final ObjectMapper mapper = new ObjectMapper();
    private static final String sourceUrl = "https://h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com/develop/baminchan";
    private static final String[] mains = new String[]{"HBDEF", "HDF73", "HF778", "HFB53", "H077F", "H4665", "H1AA9", "HEDFB"};
    private static final String[] soups = new String[]{"H72C3", "HA6EE", "H8CD0", "HE2E9", "HAA47", "H3254", "H26C7", "HFFF9"};
    private static final String[] sides = new String[]{"HBBCC", "H1939", "H8EA5", "H602F", "H9F0B", "H0FC6", "HCCFE", "HB9C1"};

    private final BanchanDao banchanDao;
    private final ImageDao imageDao;
    private final CategoryDao categoryDao;
    private final DeliveryDao deliveryDao;
    private final DiscountDao discountDao;

    public DbInitService(BanchanDao banchanDao, ImageDao imageDao, CategoryDao categoryDao, DeliveryDao deliveryDao, DiscountDao discountDao) {
        this.banchanDao = banchanDao;
        this.imageDao = imageDao;
        this.categoryDao = categoryDao;
        this.deliveryDao = deliveryDao;
        this.discountDao = discountDao;
    }

    public void initDb() throws JsonProcessingException {
        insertDefaultCategories();
        insertDefaultDeliveries();
        insertDefaultDiscounts();
        insertAllBanchansInCategory("main", mains);
        insertAllBanchansInCategory("soup", soups);
        insertAllBanchansInCategory("side", sides);
    }

    private void insertDefaultCategories() {
        Category main = Category.builder()
                                .path("main")
                                .name("메인반찬")
                                .description("한그릇 뚝딱 메인 요리")
                                .banchans(new HashSet<>())
                                .build();
        Category soup = Category.builder()
                                .path("soup")
                                .name("국・찌개")
                                .description("김이 모락모락 국・찌개")
                                .banchans(new HashSet<>())
                                .build();
        Category side = Category.builder()
                                .path("side")
                                .name("밑반찬")
                                .description("언제 먹어도 든든한 밑반찬")
                                .banchans(new HashSet<>())
                                .build();
        categoryDao.insertCategory(main);
        categoryDao.insertCategory(soup);
        categoryDao.insertCategory(side);
    }

    private void insertDefaultDeliveries() {
        Delivery delivery1 = Delivery.builder()
                                     .name("새벽배송")
                                     .info("서울 경기 새벽배송")
                                     .fee("2,500원 (40,000원 이상 구매 시 무료)")
                                     .build();
        Delivery delivery2 = Delivery.builder()
                                     .name("전국택배")
                                     .info("전국택배 (제주 및 도서산간 불가) [월 · 화 · 수 · 목 · 금 · 토] 수령 가능한 상품입니다.")
                                     .fee("2,500원 (40,000원 이상 구매 시 무료)")
                                     .build();
        deliveryDao.insertDelivery(delivery1);
        deliveryDao.insertDelivery(delivery2);
    }

    private void insertDefaultDiscounts() {
        Discount discount1 = Discount.builder()
                                     .name("이벤트특가")
                                     .rate(0.05)
                                     .build();
        Discount discount2 = Discount.builder()
                                     .name("론칭특가")
                                     .rate(0.1)
                                     .build();
        discountDao.insertDiscount(discount1);
        discountDao.insertDiscount(discount2);
    }

    private void insertAllBanchansInCategory(String categoryPath, String[] banchanIds) throws JsonProcessingException {
        for (String banchanId : banchanIds) {
            insertBanchanInCategory(categoryPath, banchanId);
        }
    }

    private void insertBanchanInCategory(String categoryPath, String banchanId) throws JsonProcessingException {
        String summaryUrl = new StringJoiner("/")
                            .add(sourceUrl)
                            .add(categoryPath)
                            .add(banchanId)
                            .toString();
        String detailUrl = new StringJoiner("/")
                           .add(sourceUrl)
                           .add("detail")
                           .add(banchanId)
                           .toString();
        Banchan banchan = initializeBanchan(summaryUrl, detailUrl);
        insertBanchan(banchan, categoryPath);
    }

    private Banchan initializeBanchan(String summaryUrl, String detailUrl) throws JsonProcessingException {
        ResponseEntity<String> summaryResponse = restTemplate.getForEntity(summaryUrl, String.class);
        ResponseEntity<String> detailResponse = restTemplate.getForEntity(detailUrl, String.class);
        JsonNode summaryNode = mapper.readTree(summaryResponse.getBody());
        JsonNode detailNode = mapper.readTree(detailResponse.getBody()).get("data");

        Banchan banchan = partiallyInitializeBanchan(summaryNode);
        banchan.setImages(initializeImages(summaryNode, detailNode));

        return banchan;
    }

    private Banchan partiallyInitializeBanchan(JsonNode summaryNode) {
        Banchan banchan = Banchan.builder()
                                 .id(summaryNode.required("detail_hash").asText())
                                 .title(summaryNode.required("title").asText())
                                 .description(summaryNode.required("description").asText())
                                 .price(parsePrice(summaryNode))
                                 .deliveries(new HashSet<>())
                                 .discounts(new HashSet<>())
                                 .build();

        for (JsonNode deliveryNode : summaryNode.required("delivery_type")) {
            String deliveryName = deliveryNode.asText();
            Delivery delivery = deliveryDao.findDeliveryByName(deliveryName);
            banchan.addDelivery(delivery);
        }

        JsonNode discounts = summaryNode.get("badge");
        if (discounts != null ) {
            for (JsonNode discountNode : discounts) {
                String discountName = discountNode.asText();
                Discount discount = discountDao.findDiscountByName(discountName);
                banchan.addDiscount(discount);
            }
        }

        return banchan;
    }

    private Images initializeImages(JsonNode summaryNode, JsonNode detailNode) {
        Images images = Images.builder()
                              .summaryImage(summaryNode.required("image").asText())
                              .topImage(detailNode.get("top_image").asText())
                              .thumbImages(new ArrayList<>())
                              .detailImages(new ArrayList<>())
                              .build();

        for (JsonNode thumbImageNode : detailNode.required("thumb_images")) {
            String thumbImageUrl = thumbImageNode.asText();
            images.addThumbImage(thumbImageUrl);
        }

        for (JsonNode detailImageNode : detailNode.required("detail_section")) {
            String detailImageUrl = detailImageNode.asText();
            images.addDetailImage(detailImageUrl);
        }

        return images;
    }

    private int parsePrice(JsonNode summaryNode) {
        String priceString = summaryNode.required("s_price").asText();
        String unformattedPriceString = priceString.substring(0, priceString.length() - 1);
        unformattedPriceString = unformattedPriceString.replace(",", "");
        return Integer.parseInt(unformattedPriceString);
    }

    private void insertBanchan(Banchan banchan, String categoryPath) {
        banchanDao.insertIntoBanchanTable(banchan, categoryPath);
        imageDao.insertAllImagesIntoImageTable(banchan);
        deliveryDao.insertIntoBanchanDeliveryTable(banchan);
        discountDao.insertIntoBanchanDiscountTable(banchan);
    }

}
