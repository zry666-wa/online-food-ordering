package com.food.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.food.entity.CartItem;
import com.food.entity.User;
import com.food.service.CartService;

/** 购物车控制器 */
@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CartService cartService = new CartService();

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

        if ("add".equals(action)) {
            Integer dishId = parseInt(request.getParameter("dishId"));
            if (dishId != null) {
                cartService.add(user.getId(), dishId);
            }
            response.sendRedirect(request.getContextPath() + "/CartServlet?action=list");
            return;
        }

        if ("updateQty".equals(action)) {
            Integer id = parseInt(request.getParameter("id"));
            Integer qty = parseInt(request.getParameter("quantity"));
            if (id != null && qty != null) cartService.updateQuantity(id, qty);
            response.sendRedirect(request.getContextPath() + "/CartServlet?action=list");
            return;
        }

        if ("delete".equals(action)) {
            Integer id = parseInt(request.getParameter("id"));
            if (id != null) cartService.delete(id);
            response.sendRedirect(request.getContextPath() + "/CartServlet?action=list");
            return;
        }

        // 默认 list：展示购物车
        List<CartItem> items = cartService.findByUserId(user.getId());
        double total = 0;
        for (CartItem c : items) {
            double sub = c.getPrice().doubleValue() * c.getQuantity();
            c.setSubtotal(java.math.BigDecimal.valueOf(sub));
            total += sub;
        }
        request.setAttribute("cartItems", items);
        request.setAttribute("total", total);
        request.getRequestDispatcher("/customer/cart.jsp").forward(request, response);
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
