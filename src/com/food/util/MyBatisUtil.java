package com.food.util;

import java.io.InputStream;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

/**
 * MyBatis 工具类：负责加载全局配置文件并创建 SqlSessionFactory，
 * 提供获取 SqlSession、提交/回滚/关闭会话等统一封装。
 */
public class MyBatisUtil {

    private static SqlSessionFactory factory;

    static {
        try {
            InputStream is = Resources.getResourceAsStream("mybatis-config.xml");
            factory = new SqlSessionFactoryBuilder().build(is);
        } catch (Exception e) {
            e.printStackTrace();
            throw new ExceptionInInitializerError("MyBatis 初始化失败: " + e.getMessage());
        }
    }

    /** 获取会话（默认不自动提交，业务层统一控制事务） */
    public static SqlSession getSession() {
        return factory.openSession(false);
    }

    /** 获取 Mapper 接口实例 */
    public static <T> T getMapper(Class<T> mapperClass) {
        SqlSession session = getSession();
        return session.getMapper(mapperClass);
    }
}
