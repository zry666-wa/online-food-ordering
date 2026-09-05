package com.food.service;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import com.food.dao.MerchantMapper;
import com.food.entity.Merchant;
import com.food.util.MyBatisUtil;

/** 商家业务逻辑 */
public class MerchantService {

    public Merchant findById(Integer id) {
        SqlSession session = MyBatisUtil.getSession();
        try {
            return session.getMapper(MerchantMapper.class).findById(id);
        } finally {
            session.close();
        }
    }

    public Merchant findByUserId(Integer userId) {
        SqlSession session = MyBatisUtil.getSession();
        try {
            return session.getMapper(MerchantMapper.class).findByUserId(userId);
        } finally {
            session.close();
        }
    }

    public List<Merchant> findAll(Integer status, String keyword) {
        SqlSession session = MyBatisUtil.getSession();
        try {
            return session.getMapper(MerchantMapper.class).findAll(status, keyword);
        } finally {
            session.close();
        }
    }

    public boolean update(Merchant merchant) {
        SqlSession session = MyBatisUtil.getSession();
        try {
            session.getMapper(MerchantMapper.class).update(merchant);
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
            session.getMapper(MerchantMapper.class).updateStatus(id, status);
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

    public long count() {
        SqlSession session = MyBatisUtil.getSession();
        try {
            return session.getMapper(MerchantMapper.class).count();
        } finally {
            session.close();
        }
    }
}
