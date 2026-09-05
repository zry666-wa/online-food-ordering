package com.food.service;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import com.food.dao.CartMapper;
import com.food.entity.CartItem;
import com.food.util.MyBatisUtil;

/** 购物车业务逻辑 */
public class CartService {

    /** 加入购物车：若已存在则数量+1 */
    public boolean add(Integer userId, Integer dishId) {
        SqlSession session = MyBatisUtil.getSession();
        try {
            CartMapper mapper = session.getMapper(CartMapper.class);
            CartItem exist = mapper.findByUserAndDish(userId, dishId);
            if (exist != null) {
                mapper.updateQuantity(exist.getId(), exist.getQuantity() + 1);
            } else {
                CartItem item = new CartItem();
                item.setUserId(userId);
                item.setDishId(dishId);
                item.setQuantity(1);
                mapper.insert(item);
            }
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

    public List<CartItem> findByUserId(Integer userId) {
        SqlSession session = MyBatisUtil.getSession();
        try {
            return session.getMapper(CartMapper.class).findByUserId(userId);
        } finally {
            session.close();
        }
    }

    public boolean updateQuantity(Integer id, Integer quantity) {
        SqlSession session = MyBatisUtil.getSession();
        try {
            if (quantity <= 0) {
                session.getMapper(CartMapper.class).delete(id);
            } else {
                session.getMapper(CartMapper.class).updateQuantity(id, quantity);
            }
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

    public boolean delete(Integer id) {
        SqlSession session = MyBatisUtil.getSession();
        try {
            session.getMapper(CartMapper.class).delete(id);
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

    public long countByUserId(Integer userId) {
        SqlSession session = MyBatisUtil.getSession();
        try {
            return session.getMapper(CartMapper.class).countByUserId(userId);
        } finally {
            session.close();
        }
    }
}
