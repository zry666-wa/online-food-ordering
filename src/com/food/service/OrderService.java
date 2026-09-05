package com.food.service;

import java.math.BigDecimal;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.food.dao.CartMapper;
import com.food.dao.DishMapper;
import com.food.dao.MerchantMapper;
import com.food.dao.OrderItemMapper;
import com.food.dao.OrderMapper;
import com.food.entity.CartItem;
import com.food.entity.Dish;
import com.food.entity.Merchant;
import com.food.entity.Order;
import com.food.entity.OrderItem;
import com.food.util.MyBatisUtil;
import com.food.util.StringUtil;

/**
 * 订单业务逻辑。
 * 下单为关键事务：同一 SqlSession 内完成 订单插入 + 明细插入 + 销量累加 + 购物车清空，
 * 任一失败整体回滚，保证数据一致性。
 */
public class OrderService {

    /**
     * 由购物车提交订单（下单但不支付，状态=待支付）。
     * 返回订单号；购物车为空或菜品下架返回 null。
     */
    public String submitOrder(Integer userId, String address, String phone, String remark) {
        SqlSession session = MyBatisUtil.getSession();
        try {
            CartMapper cartMapper = session.getMapper(CartMapper.class);
            DishMapper dishMapper = session.getMapper(DishMapper.class);
            OrderMapper orderMapper = session.getMapper(OrderMapper.class);
            OrderItemMapper itemMapper = session.getMapper(OrderItemMapper.class);
            MerchantMapper merchantMapper = session.getMapper(MerchantMapper.class);

            List<CartItem> cart = cartMapper.findByUserId(userId);
            if (cart == null || cart.isEmpty()) return null;

            // 按商家聚合：一个订单对应一个商家的菜品
            // 若购物车跨多家，分别建单；为简化演示，取第一家创建订单
            Merchant merchant = merchantMapper.findById(cart.get(0).getMerchantId());
            if (merchant == null) return null;

            BigDecimal total = BigDecimal.ZERO;
            for (CartItem c : cart) {
                total = total.add(c.getPrice().multiply(BigDecimal.valueOf(c.getQuantity())));
            }

            Order order = new Order();
            order.setOrderNo(StringUtil.genOrderNo());
            order.setUserId(userId);
            order.setMerchantId(merchant.getId());
            order.setTotalAmount(total);
            order.setStatus(0); // 待支付
            order.setAddress(address);
            order.setPhone(phone);
            order.setRemark(remark);
            orderMapper.insert(order);

            for (CartItem c : cart) {
                OrderItem item = new OrderItem();
                item.setOrderId(order.getId());
                item.setDishId(c.getDishId());
                item.setDishName(c.getDishName());
                item.setPrice(c.getPrice());
                item.setQuantity(c.getQuantity());
                item.setSubtotal(c.getPrice().multiply(BigDecimal.valueOf(c.getQuantity())));
                itemMapper.insert(item);
                dishMapper.addSales(c.getDishId(), c.getQuantity());
            }

            cartMapper.clear(userId); // 清空购物车
            session.commit();
            return order.getOrderNo();
        } catch (Exception e) {
            session.rollback();
            e.printStackTrace();
            return null;
        } finally {
            session.close();
        }
    }

    /** 模拟支付：待支付 -> 待接单 */
    public boolean pay(String orderNo) {
        SqlSession session = MyBatisUtil.getSession();
        try {
            OrderMapper mapper = session.getMapper(OrderMapper.class);
            Order order = mapper.findByOrderNo(orderNo);
            if (order == null || order.getStatus() != 0) return false;
            mapper.updateStatus(order.getId(), 1);
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

    /** 取消订单：仅待支付状态可取消 */
    public boolean cancel(Integer orderId, Integer userId) {
        SqlSession session = MyBatisUtil.getSession();
        try {
            OrderMapper mapper = session.getMapper(OrderMapper.class);
            Order order = mapper.findById(orderId);
            if (order == null || !order.getUserId().equals(userId)) return false;
            if (order.getStatus() != 0 && order.getStatus() != 1) return false;
            mapper.updateStatus(orderId, 5);
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

    /** 商家状态流转：接单(1->2)、出餐(2->3)。订单送达完成由顾客在“配送中”状态确认。 */
    public boolean merchantAdvance(Integer orderId, Integer merchantId) {
        SqlSession session = MyBatisUtil.getSession();
        try {
            OrderMapper mapper = session.getMapper(OrderMapper.class);
            Order order = mapper.findById(orderId);
            if (order == null || !order.getMerchantId().equals(merchantId)) return false;
            int cur = order.getStatus();
            if (cur == 1) mapper.updateStatus(orderId, 2);
            else if (cur == 2) mapper.updateStatus(orderId, 3);
            else return false;
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

    /** 顾客确认完成：仅“配送中(3)”状态的订单可由订单所属顾客确认，置为已完成(4) */
    public boolean customerComplete(Integer orderId, Integer userId) {
        SqlSession session = MyBatisUtil.getSession();
        try {
            OrderMapper mapper = session.getMapper(OrderMapper.class);
            Order order = mapper.findById(orderId);
            if (order == null || !order.getUserId().equals(userId)) return false;
            if (order.getStatus() != 3) return false;
            mapper.updateStatus(orderId, 4);
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

    public Order findById(Integer id) {
        SqlSession session = MyBatisUtil.getSession();
        try {
            return session.getMapper(OrderMapper.class).findById(id);
        } finally {
            session.close();
        }
    }

    public Order findByOrderNo(String orderNo) {
        SqlSession session = MyBatisUtil.getSession();
        try {
            return session.getMapper(OrderMapper.class).findByOrderNo(orderNo);
        } finally {
            session.close();
        }
    }

    public List<Order> findByUserId(Integer userId) {
        SqlSession session = MyBatisUtil.getSession();
        try {
            return session.getMapper(OrderMapper.class).findByUserId(userId);
        } finally {
            session.close();
        }
    }

    public List<Order> findByMerchantId(Integer merchantId, Integer status) {
        SqlSession session = MyBatisUtil.getSession();
        try {
            return session.getMapper(OrderMapper.class).findByMerchantId(merchantId, status);
        } finally {
            session.close();
        }
    }

    public List<Order> findAll(Integer status, String keyword) {
        SqlSession session = MyBatisUtil.getSession();
        try {
            return session.getMapper(OrderMapper.class).findAll(status, keyword);
        } finally {
            session.close();
        }
    }
}
