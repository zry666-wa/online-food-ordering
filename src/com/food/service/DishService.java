package com.food.service;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import com.food.dao.DishMapper;
import com.food.entity.Dish;
import com.food.util.MyBatisUtil;

/** 菜品业务逻辑 */
public class DishService {

    public Dish findById(Integer id) {
        SqlSession session = MyBatisUtil.getSession();
        try {
            return session.getMapper(DishMapper.class).findById(id);
        } finally {
            session.close();
        }
    }

    public List<Dish> findAll(Integer categoryId, Integer merchantId, String keyword, Integer status) {
        SqlSession session = MyBatisUtil.getSession();
        try {
            return session.getMapper(DishMapper.class).findAll(categoryId, merchantId, keyword, status);
        } finally {
            session.close();
        }
    }

    public boolean add(Dish dish) {
        SqlSession session = MyBatisUtil.getSession();
        try {
            session.getMapper(DishMapper.class).insert(dish);
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

    public boolean update(Dish dish) {
        SqlSession session = MyBatisUtil.getSession();
        try {
            session.getMapper(DishMapper.class).update(dish);
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

    public boolean updateStatus(Integer id, Integer status) {
        SqlSession session = MyBatisUtil.getSession();
        try {
            session.getMapper(DishMapper.class).updateStatus(id, status);
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
            session.getMapper(DishMapper.class).delete(id);
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
}
