package com.food.util;

import java.security.MessageDigest;
import java.util.UUID;

/**
 * 通用工具类：MD5 加密、字符串判空、订单号生成等。
 */
public class StringUtil {

    /** MD5 加密 */
    public static String md5(String input) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] digest = md.digest(input.getBytes("UTF-8"));
            StringBuilder sb = new StringBuilder();
            for (byte b : digest) {
                String hex = Integer.toHexString(b & 0xff);
                if (hex.length() == 1) sb.append('0');
                sb.append(hex);
            }
            return sb.toString();
        } catch (Exception e) {
            throw new RuntimeException("MD5 加密失败", e);
        }
    }

    public static boolean isEmpty(String s) {
        return s == null || s.trim().isEmpty();
    }

    /** 生成订单号: yyyyMMddHHmmss + 4位随机 */
    public static String genOrderNo() {
        return new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date())
                + String.format("%04d", (int) (Math.random() * 10000));
    }
}
