package com.food.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.food.entity.Order;

/** 订单数据访问接口 */
public interface OrderMapper {
    Order findById(@Param("id") Integer id);
    Order findByOrderNo(@Param("orderNo") String orderNo);
    List<Order> findByUserId(@Param("userId") Integer userId);
    List<Order> findByMerchantId(@Param("merchantId") Integer merchantId, @Param("status") Integer status);
    List<Order> findAll(@Param("status") Integer status, @Param("keyword") String keyword);
    int insert(Order order);
    int update(Order order);
    int updateStatus(@Param("id") Integer id, @Param("status") Integer status);
    long countByStatus(@Param("status") Integer status);
    java.math.BigDecimal sumAmount();
}
