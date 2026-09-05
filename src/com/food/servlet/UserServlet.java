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

/** 个人中心控制器：资料修改、密码修改 */
@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        if ("updateProfile".equals(action)) {
            loginUser.setRealName(request.getParameter("realName"));
            loginUser.setPhone(request.getParameter("phone"));
            loginUser.setEmail(request.getParameter("email"));
            if (userService.updateProfile(loginUser)) {
                session.setAttribute("loginUser", userService.findById(loginUser.getId()));
                request.setAttribute("msg", "资料修改成功");
            } else {
                request.setAttribute("error", "资料修改失败");
            }
            request.getRequestDispatcher("/customer/profile.jsp").forward(request, response);
            return;
        }

        if ("changePassword".equals(action)) {
            String oldPwd = request.getParameter("oldPassword");
            String newPwd = request.getParameter("newPassword");
            if (!userService.findById(loginUser.getId()).getPassword()
                    .equals(com.food.util.StringUtil.md5(oldPwd))) {
                request.setAttribute("error", "原密码错误");
            } else if (newPwd == null || newPwd.length() < 6) {
                request.setAttribute("error", "新密码至少6位");
            } else {
                userService.changePassword(loginUser.getId(), newPwd);
                request.setAttribute("msg", "密码修改成功");
            }
            request.getRequestDispatcher("/customer/profile.jsp").forward(request, response);
            return;
        }
        response.sendRedirect(request.getContextPath() + "/customer/profile.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}
