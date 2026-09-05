package com.food.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.food.entity.Review;

/** 评价数据访问接口 */
public interface ReviewMapper {
    List<Review> findByDishId(@Param("dishId") Integer dishId);
    List<Review> findByMerchantId(@Param("merchantId") Integer merchantId);
    List<Review> findAll();
    Review findByOrderAndDish(@Param("orderId") Integer orderId, @Param("dishId") Integer dishId);
    int insert(Review review);
    int delete(@Param("id") Integer id);
    double avgRatingByDish(@Param("dishId") Integer dishId);
    double avgRatingByMerchant(@Param("merchantId") Integer merchantId);
}
