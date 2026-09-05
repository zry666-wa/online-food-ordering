package com.food.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.food.entity.Order;
import com.food.entity.User;
import com.food.service.OrderService;

/** 顾客订单控制器：确认下单、模拟支付、取消、订单列表与详情 */
@WebServlet("/OrderServlet")
public class OrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private OrderService orderService = new OrderService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("loginUser");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        if ("confirm".equals(action)) {
            // 展示下单确认页（从购物车）
            java.util.List<com.food.entity.CartItem> items =
                    new com.food.service.CartService().findByUserId(user.getId());
            double total = 0;
            for (com.food.entity.CartItem c : items) {
                total += c.getPrice().doubleValue() * c.getQuantity();
            }
            request.setAttribute("cartItems", items);
            request.setAttribute("total", total);
            request.getRequestDispatcher("/customer/order_confirm.jsp").forward(request, response);
            return;
        }

        if ("submit".equals(action)) {
            String address = request.getParameter("address");
            String phone = request.getParameter("phone");
            String remark = request.getParameter("remark");
            if (address == null || address.trim().isEmpty() || phone == null || phone.trim().isEmpty()) {
                request.setAttribute("error", "请填写配送地址和联系电话");
                java.util.List<com.food.entity.CartItem> items =
                        new com.food.service.CartService().findByUserId(user.getId());
                request.setAttribute("cartItems", items);
                request.getRequestDispatcher("/customer/order_confirm.jsp").forward(request, response);
                return;
            }
            String orderNo = orderService.submitOrder(user.getId(), address.trim(), phone.trim(), remark);
            if (orderNo == null) {
                request.setAttribute("error", "下单失败：购物车为空或菜品已下架");
                request.getRequestDispatcher("/customer/cart.jsp").forward(request, response);
                return;
            }
            request.setAttribute("orderNo", orderNo);
            request.setAttribute("msg", "订单提交成功");
            request.getRequestDispatcher("/customer/order_success.jsp").forward(request, response);
            return;
        }

        if ("pay".equals(action)) {
            String orderNo = request.getParameter("orderNo");
            if (orderNo != null) orderService.pay(orderNo);
            response.sendRedirect(request.getContextPath() + "/OrderServlet?action=list");
            return;
        }

        if ("cancel".equals(action)) {
            Integer id = parseInt(request.getParameter("id"));
            if (id != null) orderService.cancel(id, user.getId());
            response.sendRedirect(request.getContextPath() + "/OrderServlet?action=list");
            return;
        }

        if ("complete".equals(action)) {
            // 顾客确认完成：配送中的订单由顾客点击“确认完成”
            Integer id = parseInt(request.getParameter("id"));
            if (id != null) orderService.customerComplete(id, user.getId());
            response.sendRedirect(request.getContextPath() + "/OrderServlet?action=list");
            return;
        }

        if ("detail".equals(action)) {
            Integer id = parseInt(request.getParameter("id"));
            Order order = orderService.findById(id);
            if (order == null || !order.getUserId().equals(user.getId())) {
                response.sendRedirect(request.getContextPath() + "/OrderServlet?action=list");
                return;
            }
            request.setAttribute("order", order);
            request.getRequestDispatcher("/customer/order_detail.jsp").forward(request, response);
            return;
        }

        // 默认 list
        List<Order> orders = orderService.findByUserId(user.getId());
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("/customer/order_list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    private Integer parseInt(String s) {
        try {
            return s == null ? null : Integer.valueOf(s);
        } catch (NumberFormatException e) {
            return null;
        }
    }
}
