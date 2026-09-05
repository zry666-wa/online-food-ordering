package com.food.service;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.food.dao.DishMapper;
import com.food.dao.MerchantMapper;
import com.food.dao.OrderMapper;
import com.food.dao.ReviewMapper;
import com.food.dao.UserMapper;
import com.food.entity.Dish;
import com.food.entity.Order;
import com.food.util.MyBatisUtil;

/** 统计业务逻辑：为系统管理员与商家经营看板提供汇总数据 */
public class StatisticsService {

    /** 系统级统计总览 */
    public Map<String, Object> systemStats() {
        Map<String, Object> stats = new HashMap<>();
        SqlSession session = MyBatisUtil.getSession();
        try {
            UserMapper userMapper = session.getMapper(UserMapper.class);
            MerchantMapper merchantMapper = session.getMapper(MerchantMapper.class);
            DishMapper dishMapper = session.getMapper(DishMapper.class);
            OrderMapper orderMapper = session.getMapper(OrderMapper.class);
            stats.put("customerCount", userMapper.countByRole("customer"));
            stats.put("merchantCount", merchantMapper.count());
            stats.put("dishCount", dishMapper.countAll());
            long orderCount = 0;
            for (int i = 0; i <= 5; i++) orderCount += orderMapper.countByStatus(i);
            stats.put("orderCount", orderCount);
            stats.put("finishedCount", orderMapper.countByStatus(4));
            BigDecimal amount = orderMapper.sumAmount();
            stats.put("totalAmount", amount == null ? BigDecimal.ZERO : amount);
        } finally {
            session.close();
        }
        return stats;
    }

    /** 商家级统计：订单数、销售额、热销菜品、评价均分 */
    public Map<String, Object> merchantStats(Integer merchantId) {
        Map<String, Object> stats = new HashMap<>();
        SqlSession session = MyBatisUtil.getSession();
        try {
            OrderMapper orderMapper = session.getMapper(OrderMapper.class);
            DishMapper dishMapper = session.getMapper(DishMapper.class);
            ReviewMapper reviewMapper = session.getMapper(ReviewMapper.class);

            List<Order> orders = orderMapper.findByMerchantId(merchantId, null);
            BigDecimal amount = BigDecimal.ZERO;
            int finished = 0;
            int pending = 0;
            for (Order o : orders) {
                if (o.getStatus() == 4) {
                    amount = amount.add(o.getTotalAmount());
                    finished++;
                } else if (o.getStatus() == 1) {
                    pending++;
                }
            }
            List<Dish> dishes = dishMapper.findAll(null, merchantId, null, null);
            dishes.sort((a, b) -> Integer.compare(
                    b.getSales() == null ? 0 : b.getSales(),
                    a.getSales() == null ? 0 : a.getSales()));
            List<Dish> hot = dishes.size() > 5 ? dishes.subList(0, 5) : dishes;

            stats.put("orderCount", orders.size());
            stats.put("finishedCount", finished);
            stats.put("pendingCount", pending);
            stats.put("totalAmount", amount);
            stats.put("hotDishes", hot);
            stats.put("avgRating", reviewMapper.avgRatingByMerchant(merchantId));
            stats.put("dishCount", dishes.size());
        } finally {
            session.close();
        }
        return stats;
    }
}
