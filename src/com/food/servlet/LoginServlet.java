package com.food.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.food.entity.User;
import com.food.service.UserService;

/** 登录/退出控制器 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("logout".equals(action)) {
            request.getSession().invalidate();
            response.sendRedirect(request.getContextPath() + "/DishServlet");
            return;
        }
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        if (username == null || password == null || username.trim().isEmpty() || password.isEmpty()) {
            request.setAttribute("error", "用户名和密码不能为空");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }
        User user = userService.login(username.trim(), password);
        if (user == null) {
            request.setAttribute("error", "用户名或密码错误，或账号已被禁用");
            request.setAttribute("username", username);
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }
        HttpSession session = request.getSession();
        session.setAttribute("loginUser", user);
        // 按角色跳转
        if ("admin".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/AdminServlet?action=index");
        } else if ("merchant".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/MerchantServlet?action=dashboard");
        } else {
            response.sendRedirect(request.getContextPath() + "/DishServlet");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}
