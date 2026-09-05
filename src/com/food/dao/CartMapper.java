package com.food.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.food.entity.CartItem;

/** 购物车数据访问接口 */
public interface CartMapper {
    List<CartItem> findByUserId(@Param("userId") Integer userId);
    CartItem findByUserAndDish(@Param("userId") Integer userId, @Param("dishId") Integer dishId);
    int insert(CartItem item);
    int updateQuantity(@Param("id") Integer id, @Param("quantity") Integer quantity);
    int delete(@Param("id") Integer id);
    int clear(@Param("userId") Integer userId);
    long countByUserId(@Param("userId") Integer userId);
}
