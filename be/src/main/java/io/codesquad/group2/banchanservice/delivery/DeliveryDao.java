package io.codesquad.group2.banchanservice.delivery;

import io.codesquad.group2.banchanservice.banchan.Banchan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Repository
public class DeliveryDao {

    private static final Logger logger = LoggerFactory.getLogger(DeliveryDao.class);

    private final JdbcTemplate jdbcTemplate;
    private final NamedParameterJdbcTemplate namedParameterJdbcTemplate;

    public DeliveryDao(DataSource dataSource) {
        jdbcTemplate = new JdbcTemplate(dataSource);
        namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
    }

    public Delivery findDeliveryByName(String deliveryName) {
        String sql = "SELECT name, info, fee FROM delivery WHERE name = ?";
        return jdbcTemplate.queryForObject(sql, new Object[]{deliveryName},
                                           (rs, rowNum) -> Delivery.builder()
                                                                   .name(rs.getString("name"))
                                                                   .info(rs.getString("info"))
                                                                   .fee(rs.getString("fee"))
                                                                   .build());
    }

    public Set<Delivery> findDeliveriesByBanchanId(String banchanId) {
        String sql = "SELECT bd.delivery FROM delivery d " +
                     "JOIN banchan_delivery bd ON d.name = bd.delivery " +
                     "WHERE bd.banchan = ?";
        List<String> deliveryNames = jdbcTemplate.queryForList(sql, new Object[]{banchanId}, String.class);
        return deliveryNames.stream()
                            .map(this::findDeliveryByName)
                            .collect(Collectors.toSet());
    }

    public void insertDelivery(Delivery delivery) {
        String sql = "INSERT INTO delivery (name, info, fee) " +
                     "VALUES (:name, :info, :fee)";
        SqlParameterSource namedParameters = new MapSqlParameterSource()
                                             .addValue("name", delivery.getName())
                                             .addValue("info", delivery.getInfo())
                                             .addValue("fee", delivery.getFee());
        namedParameterJdbcTemplate.update(sql, namedParameters);
    }

    public void insertIntoBanchanDeliveryTable(Banchan banchan) {
        String sql = "INSERT INTO banchan_delivery (banchan, delivery) " +
                     "VALUES (:banchan, :delivery)";
        for (Delivery delivery : banchan.getDeliveries()) {
            SqlParameterSource namedParameters = new MapSqlParameterSource()
                                                 .addValue("banchan", banchan.getId())
                                                 .addValue("delivery", delivery.getName());
            namedParameterJdbcTemplate.update(sql, namedParameters);
        }
    }

    }
