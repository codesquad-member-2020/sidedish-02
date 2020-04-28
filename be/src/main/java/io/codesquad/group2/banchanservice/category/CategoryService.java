package io.codesquad.group2.banchanservice.category;

import io.codesquad.group2.banchanservice.banchan.BanchanService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class CategoryService {

    private final CategoryDao categoryDao;
    private final BanchanService banchanService;

    public CategoryService(CategoryDao categoryDao, BanchanService banchanService) {
        this.categoryDao = categoryDao;
        this.banchanService = banchanService;
    }

    public List<CategorySummaryDto> getCategorySummaryDtos() {
        return categoryDao.findAllCategories()
                          .stream()
                          .map(this::mapToSummaryDto)
                          .collect(Collectors.toList());
    }

    public CategoryDto getCategoryDtoByPath(String path) {
        return mapToDto(findByPath(path));
    }

    private Category findByPath(String path) {
        Category category = categoryDao.findByPath(path);
        category.setBanchans(banchanService.getBanchanByCategory(path));
        return category;
    }

    private CategoryDto mapToDto(Category category) {
        return CategoryDto.builder()
                          .name(category.getName())
                          .description(category.getDescription())
                          .banchan(category.getBanchans()
                                           .stream()
                                           .map(banchanService::mapToSummaryDto)
                                           .collect(Collectors.toSet()))
                          .build();
    }

    private CategorySummaryDto mapToSummaryDto(Category category) {
        return CategorySummaryDto.builder()
                                 .name(category.getName())
                                 .description(category.getDescription())
                                 .path(category.getPath())
                                 .build();
    }

}
