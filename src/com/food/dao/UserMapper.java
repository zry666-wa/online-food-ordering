package com.food.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.food.entity.User;

/** 用户数据访问接口 */
public interface UserMapper {
    User findById(@Param("id") Integer id);
    User findByUsername(@Param("username") String username);
    List<User> findAll(@Param("keyword") String keyword, @Param("role") String role);
    int insert(User user);
    int update(User user);
    int updatePassword(@Param("id") Integer id, @Param("password") String password);
    int updateStatus(@Param("id") Integer id, @Param("status") Integer status);
    int delete(@Param("id") Integer id);
    long countByRole(@Param("role") String role);
}
