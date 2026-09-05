package com.food.service;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import com.food.dao.UserMapper;
import com.food.entity.User;
import com.food.util.MyBatisUtil;
import com.food.util.StringUtil;

/** 用户业务逻辑 */
public class UserService {

    /** 登录校验，成功返回用户对象，失败返回 null */
    public User login(String username, String password) {
        SqlSession session = MyBatisUtil.getSession();
        try {
            UserMapper mapper = session.getMapper(UserMapper.class);
            User user = mapper.findByUsername(username);
            if (user == null) return null;
            if (user.getStatus() != null && user.getStatus() == 0) return null; // 被禁用
            if (!user.getPassword().equals(StringUtil.md5(password))) return null;
            return user;
        } finally {
            session.close();
        }
    }

    /** 用户名是否已存在 */
    public boolean usernameExists(String username) {
        SqlSession session = MyBatisUtil.getSession();
        try {
            return session.getMapper(UserMapper.class).findByUsername(username) != null;
        } finally {
            session.close();
        }
    }

    /** 注册普通用户 */
    public boolean register(User user, String rawPassword) {
        SqlSession session = MyBatisUtil.getSession();
        try {
            user.setPassword(StringUtil.md5(rawPassword));
            user.setRole("customer");
            session.getMapper(UserMapper.class).insert(user);
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

    /** 商家入驻注册（注册用户 + 创建商家申请） */
    public boolean registerMerchant(User user, String rawPassword, com.food.entity.Merchant merchant) {
        SqlSession session = MyBatisUtil.getSession();
        try {
            user.setPassword(StringUtil.md5(rawPassword));
            user.setRole("merchant");
            session.getMapper(UserMapper.class).insert(user);
            merchant.setUserId(user.getId());
            session.getMapper(com.food.dao.MerchantMapper.class).insert(merchant);
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

    public User findById(Integer id) {
        SqlSession session = MyBatisUtil.getSession();
        try {
            return session.getMapper(UserMapper.class).findById(id);
        } finally {
            session.close();
        }
    }

    public boolean updateProfile(User user) {
        SqlSession session = MyBatisUtil.getSession();
        try {
            session.getMapper(UserMapper.class).update(user);
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

    public boolean changePassword(Integer id, String newPwd) {
        SqlSession session = MyBatisUtil.getSession();
        try {
            session.getMapper(UserMapper.class).updatePassword(id, StringUtil.md5(newPwd));
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

    public List<User> findAll(String keyword, String role) {
        SqlSession session = MyBatisUtil.getSession();
        try {
            return session.getMapper(UserMapper.class).findAll(keyword, role);
        } finally {
            session.close();
        }
    }

    public boolean updateStatus(Integer id, Integer status) {
        SqlSession session = MyBatisUtil.getSession();
        try {
            session.getMapper(UserMapper.class).updateStatus(id, status);
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

    public long countByRole(String role) {
        SqlSession session = MyBatisUtil.getSession();
        try {
            return session.getMapper(UserMapper.class).countByRole(role);
        } finally {
            session.close();
        }
    }
}
