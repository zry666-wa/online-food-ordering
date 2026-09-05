package com.food.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.food.entity.Merchant;
import com.food.entity.User;
import com.food.service.UserService;

/** 注册控制器：普通顾客注册 与 商家入驻注册 */
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String type = request.getParameter("type"); // customer / merchant
        String username = trim(request.getParameter("username"));
        String password = request.getParameter("password");
        String confirm = request.getParameter("confirmPassword");
        String realName = trim(request.getParameter("realName"));
        String phone = trim(request.getParameter("phone"));
        String email = trim(request.getParameter("email"));

        // 基础校验：用户名无格式限制（仅不允许为空、不可重复），密码需含大小写字母和数字
        if (username == null || username.isEmpty() || password == null || password.isEmpty()) {
            request.setAttribute("error", "用户名和密码不能为空");
            request.setAttribute("type", type);
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }
        if (!password.equals(confirm)) {
            request.setAttribute("error", "两次输入的密码不一致");
            request.setAttribute("type", type);
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }
        // 密码至少同时包含大写字母、小写字母和数字
        if (!password.matches("(?=.*[a-z])(?=.*[A-Z])(?=.*\\d).+")) {
            request.setAttribute("error", "密码必须同时包含大写字母、小写字母和数字");
            request.setAttribute("type", type);
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }
        if (userService.usernameExists(username)) {
            request.setAttribute("error", "用户名已存在，请更换");
            request.setAttribute("type", type);
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        User user = new User();
        user.setUsername(username);
        user.setRealName(realName);
        user.setPhone(phone);
        user.setEmail(email);

        boolean ok;
        if ("merchant".equals(type)) {
            Merchant merchant = new Merchant();
            merchant.setShopName(trim(request.getParameter("shopName")));
            merchant.setShopDesc(trim(request.getParameter("shopDesc")));
            merchant.setAddress(trim(request.getParameter("address")));
            merchant.setLicenseNo(trim(request.getParameter("licenseNo")));
            ok = userService.registerMerchant(user, password, merchant);
        } else {
            ok = userService.register(user, password);
        }

        if (ok) {
            request.setAttribute("msg", "注册成功！请登录使用系统"
                    + ("merchant".equals(type) ? "（商家入驻申请已提交，等待管理员审核后即可上架菜品）" : ""));
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "注册失败，请稍后重试");
            request.setAttribute("type", type);
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/register.jsp");
    }

    private String trim(String s) {
        return s == null ? "" : s.trim();
    }
}
