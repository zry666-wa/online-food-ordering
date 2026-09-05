package com.food.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.food.entity.OrderItem;

/** 订单明细数据访问接口 */
public interface OrderItemMapper {
    List<OrderItem> findByOrderId(@Param("orderId") Integer orderId);
    int insert(OrderItem item);
    int insertBatch(@Param("list") List<OrderItem> list);
}
