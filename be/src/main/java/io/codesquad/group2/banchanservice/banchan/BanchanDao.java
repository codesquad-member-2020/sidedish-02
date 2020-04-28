package io.codesquad.group2.banchanservice.banchan;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.util.List;

@Repository
public class BanchanDao {

    private static final Logger logger = LoggerFactory.getLogger(BanchanDao.class);

    private final JdbcTemplate jdbcTemplate;
    private final NamedParameterJdbcTemplate namedParameterJdbcTemplate;

    public BanchanDao(DataSource dataSource) {
        jdbcTemplate = new JdbcTemplate(dataSource);
        namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
    }

    public Banchan findById(String id) {
        String sql = "SELECT * FROM banchan WHERE id = ?";
        return jdbcTemplate.queryForObject(sql, new Object[]{id},
                                           (rs, rowNum) -> Banchan.builder()
                                                                  .id(rs.getString("id"))
                                                                  .title(rs.getString("title"))
                                                                  .description(rs.getString("description"))
                                                                  .price(rs.getInt("price"))
                                                                  .build());
    }

    public List<String> findBanchanIdsByCategory(String categoryPath) {
        String sql = "SELECT id FROM banchan WHERE category = ?";
        return jdbcTemplate.queryForList(sql, new Object[]{categoryPath}, String.class);
    }

    public void insertIntoBanchanTable(Banchan banchan, String categoryPath) {
        String sql = "INSERT INTO banchan (id, title, description, price, category) " +
                     "VALUES (:id, :title, :description, :price, :category)";
        SqlParameterSource namedParameters = new MapSqlParameterSource()
                                             .addValue("id", banchan.getId())
                                             .addValue("title", banchan.getTitle())
                                             .addValue("description", banchan.getDescription())
                                             .addValue("price", banchan.getPrice())
                                             .addValue("category", categoryPath);
        namedParameterJdbcTemplate.update(sql, namedParameters);
    }

}
