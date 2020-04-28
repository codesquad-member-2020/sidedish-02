package io.codesquad.group2.banchanservice.discount;

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
public class DiscountDao {

    private static Logger logger = LoggerFactory.getLogger(DiscountDao.class);

    private final JdbcTemplate jdbcTemplate;
    private final NamedParameterJdbcTemplate namedParameterJdbcTemplate;

    public DiscountDao(DataSource dataSource) {
        jdbcTemplate = new JdbcTemplate(dataSource);
        namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
    }

    public Discount findDiscountByName(String discountName) {
        String sql = "SELECT name, rate FROM discount WHERE name = ?";
        return jdbcTemplate.queryForObject(sql, new Object[]{discountName}, (rs, rowNum) -> {
            return Discount.builder()
                           .name(rs.getString("name"))
                           .rate(rs.getDouble("rate"))
                           .build();
        });
    }

    public Set<Discount> findDiscountsByBanchanId(String banchanId) {
        String sql = "SELECT bd.discount FROM discount d " +
                     "JOIN banchan_discount bd ON d.name = bd.discount " +
                     "WHERE bd.banchan = ?";
        List<String> deliveryNames = jdbcTemplate.queryForList(sql, new Object[]{banchanId}, String.class);
        return deliveryNames.stream()
                            .map(this::findDiscountByName)
                            .collect(Collectors.toSet());
    }

    public void insertDiscount(Discount discount) {
        String sql = "INSERT INTO discount (name, rate) " +
                     "VALUES (:name, :rate)";
        SqlParameterSource namedParameters = new MapSqlParameterSource()
                                             .addValue("name", discount.getName())
                                             .addValue("rate", discount.getRate());
        namedParameterJdbcTemplate.update(sql, namedParameters);
    }

    public void insertIntoBanchanDiscountTable(Banchan banchan) {
        String sql = "INSERT INTO banchan_discount (banchan, discount) " +
                     "VALUES (:banchan, :discount)";
        for (Discount discount : banchan.getDiscounts()) {
            SqlParameterSource namedParameters = new MapSqlParameterSource()
                                                 .addValue("banchan", banchan.getId())
                                                 .addValue("discount", discount.getName());
            namedParameterJdbcTemplate.update(sql, namedParameters);
        }
    }

}
