package com.food.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.food.entity.Merchant;

/** 商家数据访问接口 */
public interface MerchantMapper {
    Merchant findById(@Param("id") Integer id);
    Merchant findByUserId(@Param("userId") Integer userId);
    List<Merchant> findAll(@Param("status") Integer status, @Param("keyword") String keyword);
    int insert(Merchant merchant);
    int update(Merchant merchant);
    int updateStatus(@Param("id") Integer id, @Param("status") Integer status);
    int delete(@Param("id") Integer id);
    long count();
}
