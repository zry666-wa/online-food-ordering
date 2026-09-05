package com.food.dao;

import java.util.List;
import com.food.entity.Category;

/** 菜品分类数据访问接口 */
public interface CategoryMapper {
    List<Category> findAll();
    Category findById(Integer id);
    int insert(Category category);
    int update(Category category);
    int delete(Integer id);
}
