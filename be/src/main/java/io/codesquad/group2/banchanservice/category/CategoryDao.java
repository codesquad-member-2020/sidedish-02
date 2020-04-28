package io.codesquad.group2.banchanservice.category;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.util.List;
import java.util.stream.Collectors;

@Repository
public class CategoryDao {

    private static final Logger logger = LoggerFactory.getLogger(CategoryDao.class);

    private final JdbcTemplate jdbcTemplate;
    private final NamedParameterJdbcTemplate namedParameterJdbcTemplate;

    public CategoryDao(DataSource dataSource) {
        jdbcTemplate = new JdbcTemplate(dataSource);
        namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
    }

    public List<Category> findAllCategories() {
        return findAllCategoryPaths().stream()
                                     .map(this::findByPath)
                                     .collect(Collectors.toList());

    }

    public Category findByPath(String path) {
        String sql = "SELECT * FROM category WHERE path = ?";
        return jdbcTemplate.queryForObject(sql, new Object[]{path},
                                           (rs, numRow) -> Category.builder()
                                                                   .path(rs.getString("path"))
                                                                   .name(rs.getString("name"))
                                                                   .description(rs.getString("description"))
                                                                   .build());
    }

    private List<String> findAllCategoryPaths() {
        String sql = "SELECT path FROM category";
        return jdbcTemplate.queryForList(sql, String.class);
    }

    public void insertCategory(Category category) {
        String sql = "INSERT INTO category (path, name, description) " +
                     "VALUES (:path, :name, :description)";
        SqlParameterSource namedParameters = new MapSqlParameterSource()
                                             .addValue("path", category.getPath())
                                             .addValue("name", category.getName())
                                             .addValue("description", category.getDescription());
        namedParameterJdbcTemplate.update(sql, namedParameters);
    }

}
