package com.food.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.food.entity.Order;
import com.food.entity.OrderItem;
import com.food.entity.Review;
import com.food.entity.User;
import com.food.service.OrderService;
import com.food.service.ReviewService;

/** 评价控制器：用户对已完成订单中的菜品进行评价 */
@WebServlet("/ReviewServlet")
public class ReviewServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ReviewService reviewService = new ReviewService();
    private OrderService orderService = new OrderService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("loginUser");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        Integer orderId = parseInt(request.getParameter("orderId"));
        Integer dishId = parseInt(request.getParameter("dishId"));
        Integer rating = parseInt(request.getParameter("rating"));
        String content = request.getParameter("content");

        Order order = orderService.findById(orderId);
        if (order == null || !order.getUserId().equals(user.getId()) || order.getStatus() != 4) {
            response.sendRedirect(request.getContextPath() + "/OrderServlet?action=list");
            return;
        }
        if (rating == null || rating < 1 || rating > 5) rating = 5;

        Review review = new Review();
        review.setOrderId(orderId);
        review.setUserId(user.getId());
        review.setMerchantId(order.getMerchantId());
        review.setDishId(dishId);
        review.setRating(rating);
        review.setContent(content == null ? "" : content.trim());
        reviewService.add(review);

        response.sendRedirect(request.getContextPath() + "/OrderServlet?action=detail&id=" + orderId);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    private Integer parseInt(String s) {
        try {
            return s == null ? null : Integer.valueOf(s);
        } catch (NumberFormatException e) {
            return null;
        }
    }
}
