package com.food.dao;

import java.util.List;
import com.food.entity.Announcement;

/** 公告数据访问接口 */
public interface AnnouncementMapper {
    List<Announcement> findAll();
    Announcement findById(Integer id);
    int insert(Announcement announcement);
    int update(Announcement announcement);
    int delete(Integer id);
}
