package com.food.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.food.entity.Dish;

/** 菜品数据访问接口 */
public interface DishMapper {
    Dish findById(@Param("id") Integer id);
    List<Dish> findAll(@Param("categoryId") Integer categoryId,
                       @Param("merchantId") Integer merchantId,
                       @Param("keyword") String keyword,
                       @Param("status") Integer status);
    int insert(Dish dish);
    int update(Dish dish);
    int updateStatus(@Param("id") Integer id, @Param("status") Integer status);
    int delete(@Param("id") Integer id);
    int addSales(@Param("id") Integer id, @Param("num") Integer num);
    long countByMerchant(@Param("merchantId") Integer merchantId);
    long countAll();
}
