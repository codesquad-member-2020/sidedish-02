package io.codesquad.group2.banchanservice.image;

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

@Repository
public class ImageDao {

    private static final Logger logger = LoggerFactory.getLogger(ImageDao.class);
    private static final String insertSql = "INSERT INTO image (url, banchan, is_summary_image, is_top_image, is_thumb_image, thumb_image_index, is_detail_image, detail_image_index) " +
                                            "VALUES (:url, :banchan, :is_summary_image, :is_top_image, :is_thumb_image, :thumb_image_index, :is_detail_image, :detail_image_index)";

    private final JdbcTemplate jdbcTemplate;
    private final NamedParameterJdbcTemplate namedParameterJdbcTemplate;

    public ImageDao(DataSource dataSource) {
        jdbcTemplate = new JdbcTemplate(dataSource);
        namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
    }

    public Images findImagesByBanchanId(String banchanId) {
        return Images.builder()
                     .summaryImage(findSummaryImageByBanchanId(banchanId))
                     .topImage(findTopImageByBanchanId(banchanId))
                     .thumbImages(findThumbImagesByBanchanId(banchanId))
                     .detailImages(findDetailImagesByBanchanId(banchanId))
                     .build();
    }

    public void insertAllImagesIntoImageTable(Banchan banchan) {
        insertSummaryImage(banchan);
        insertTopImage(banchan);
        insertThumbImages(banchan);
        insertDetailImages(banchan);
    }

    private String findSummaryImageByBanchanId(String banchanId) {
        String sql = "SELECT url FROM image " +
                     "WHERE banchan = ? AND is_summary_image = TRUE";
        return jdbcTemplate.queryForObject(sql, new Object[]{banchanId}, String.class);
    }

    private String findTopImageByBanchanId(String banchanId) {
        String sql = "SELECT url FROM image " +
                     "WHERE banchan = ? AND is_top_image = TRUE";
        return jdbcTemplate.queryForObject(sql, new Object[]{banchanId}, String.class);
    }

    private List<String> findThumbImagesByBanchanId(String banchanId) {
        String sql = "SELECT url FROM image " +
                     "WHERE banchan = ? AND is_thumb_image = TRUE " +
                     "ORDER BY thumb_image_index";
        return jdbcTemplate.queryForList(sql, new Object[]{banchanId}, String.class);
    }

    private List<String> findDetailImagesByBanchanId(String banchanId) {
        String sql = "SELECT url FROM image " +
                     "WHERE banchan = ? AND is_detail_image = TRUE " +
                     "ORDER BY detail_image_index";
        return jdbcTemplate.queryForList(sql, new Object[]{banchanId}, String.class);
    }

    private void insertSummaryImage(Banchan banchan) {
        SqlParameterSource namedParameters = new MapSqlParameterSource()
                                             .addValue("url", banchan.getImages().getSummaryImage())
                                             .addValue("banchan", banchan.getId())
                                             .addValue("is_summary_image", true)
                                             .addValue("is_top_image", false)
                                             .addValue("is_thumb_image", false)
                                             .addValue("thumb_image_index", -1)
                                             .addValue("is_detail_image", false)
                                             .addValue("detail_image_index", -1);
        namedParameterJdbcTemplate.update(insertSql, namedParameters);
    }

    private void insertTopImage(Banchan banchan) {
        SqlParameterSource namedParameters = new MapSqlParameterSource()
                                             .addValue("url", banchan.getImages().getTopImage())
                                             .addValue("banchan", banchan.getId())
                                             .addValue("is_summary_image", false)
                                             .addValue("is_top_image", true)
                                             .addValue("is_thumb_image", false)
                                             .addValue("thumb_image_index", -1)
                                             .addValue("is_detail_image", false)
                                             .addValue("detail_image_index", -1);
        namedParameterJdbcTemplate.update(insertSql, namedParameters);
    }

    private void insertThumbImages(Banchan banchan) {
        List<String> thumbImages = banchan.getImages().getThumbImages();
        for (int i = 0; i < thumbImages.size(); i++) {
            String thumbImage = thumbImages.get(i);
            insertThumbImageAtIndex(banchan.getId(), thumbImage, i);
        }
    }

    private void insertDetailImages(Banchan banchan) {
        List<String> detailImages = banchan.getImages().getDetailImages();
        for (int i = 0; i < detailImages.size(); i++) {
            String detailImage = detailImages.get(i);
            insertDetailImageAtIndex(banchan.getId(), detailImage, i);
        }
    }

    private void insertThumbImageAtIndex(String banchanId, String thumbImage, int index) {
        SqlParameterSource namedParameters = new MapSqlParameterSource()
                                             .addValue("url", thumbImage)
                                             .addValue("banchan", banchanId)
                                             .addValue("is_summary_image", false)
                                             .addValue("is_top_image", false)
                                             .addValue("is_thumb_image", true)
                                             .addValue("thumb_image_index", index)
                                             .addValue("is_detail_image", false)
                                             .addValue("detail_image_index", -1);
        namedParameterJdbcTemplate.update(insertSql, namedParameters);
    }

    private void insertDetailImageAtIndex(String banchanId, String detailImage, int index) {
        SqlParameterSource namedParameters = new MapSqlParameterSource()
                                             .addValue("url", detailImage)
                                             .addValue("banchan", banchanId)
                                             .addValue("is_summary_image", false)
                                             .addValue("is_top_image", false)
                                             .addValue("is_thumb_image", false)
                                             .addValue("thumb_image_index", -1)
                                             .addValue("is_detail_image", true)
                                             .addValue("detail_image_index", index);
        namedParameterJdbcTemplate.update(insertSql, namedParameters);
    }

}
