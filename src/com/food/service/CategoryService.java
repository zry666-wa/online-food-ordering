package com.food.service;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import com.food.dao.CategoryMapper;
import com.food.entity.Category;
import com.food.util.MyBatisUtil;

/** 菜品分类业务逻辑 */
public class CategoryService {

    public List<Category> findAll() {
        SqlSession session = MyBatisUtil.getSession();
        try {
            return session.getMapper(CategoryMapper.class).findAll();
        } finally {
            session.close();
        }
    }

    public boolean add(String name, Integer sort) {
        SqlSession session = MyBatisUtil.getSession();
        try {
            Category c = new Category();
            c.setName(name);
            c.setSort(sort == null ? 0 : sort);
            session.getMapper(CategoryMapper.class).insert(c);
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
            session.getMapper(CategoryMapper.class).delete(id);
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
