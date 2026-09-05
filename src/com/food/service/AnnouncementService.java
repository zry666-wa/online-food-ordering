package com.food.service;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import com.food.dao.AnnouncementMapper;
import com.food.entity.Announcement;
import com.food.util.MyBatisUtil;

/** 公告业务逻辑 */
public class AnnouncementService {

    public List<Announcement> findAll() {
        SqlSession session = MyBatisUtil.getSession();
        try {
            return session.getMapper(AnnouncementMapper.class).findAll();
        } finally {
            session.close();
        }
    }

    public boolean add(String title, String content) {
        SqlSession session = MyBatisUtil.getSession();
        try {
            Announcement a = new Announcement();
            a.setTitle(title);
            a.setContent(content);
            session.getMapper(AnnouncementMapper.class).insert(a);
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
            session.getMapper(AnnouncementMapper.class).delete(id);
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
