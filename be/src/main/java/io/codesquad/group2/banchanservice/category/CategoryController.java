package io.codesquad.group2.banchanservice.category;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class CategoryController {

    private final CategoryService categoryService;

    public CategoryController(CategoryService categoryService) {
        this.categoryService = categoryService;
    }

    @GetMapping("/categories")
    public ResponseEntity<List<CategorySummaryDto>> getCategoryList() {
        return ResponseEntity.ok(categoryService.getCategorySummaryDtos());
    }

    @GetMapping("/categories/{path}")
    public ResponseEntity<CategoryDto> getCategory(@PathVariable String path) {
        return ResponseEntity.ok(categoryService.getCategoryDtoByPath(path));
    }

}
