package com.food.service;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import com.food.dao.ReviewMapper;
import com.food.entity.Review;
import com.food.util.MyBatisUtil;

/** 评价业务逻辑 */
public class ReviewService {

    /** 新增评价：同一订单同一菜品只能评价一次 */
    public boolean add(Review review) {
        SqlSession session = MyBatisUtil.getSession();
        try {
            ReviewMapper mapper = session.getMapper(ReviewMapper.class);
            if (mapper.findByOrderAndDish(review.getOrderId(), review.getDishId()) != null) return false;
            mapper.insert(review);
            session.commit();
            return true;
        } catch (Exception e) {
            session.rollback();
            e.printStackTrace();
            return false;
        } finally {
            session.close();
        }
    }

    public List<Review> findByDishId(Integer dishId) {
        SqlSession session = MyBatisUtil.getSession();
        try {
            return session.getMapper(ReviewMapper.class).findByDishId(dishId);
        } finally {
            session.close();
        }
    }

    public List<Review> findByMerchantId(Integer merchantId) {
        SqlSession session = MyBatisUtil.getSession();
        try {
            return session.getMapper(ReviewMapper.class).findByMerchantId(merchantId);
        } finally {
            session.close();
        }
    }

    public List<Review> findAll() {
        SqlSession session = MyBatisUtil.getSession();
        try {
            return session.getMapper(ReviewMapper.class).findAll();
        } finally {
            session.close();
        }
    }

    public double avgByDish(Integer dishId) {
        SqlSession session = MyBatisUtil.getSession();
        try {
            return session.getMapper(ReviewMapper.class).avgRatingByDish(dishId);
        } finally {
            session.close();
        }
    }

    public double avgByMerchant(Integer merchantId) {
        SqlSession session = MyBatisUtil.getSession();
        try {
            return session.getMapper(ReviewMapper.class).avgRatingByMerchant(merchantId);
        } finally {
            session.close();
        }
    }
}
