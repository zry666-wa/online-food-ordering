package com.food.servlet;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.food.entity.Announcement;
import com.food.entity.Merchant;
import com.food.entity.Order;
import com.food.entity.Review;
import com.food.entity.User;
import com.food.service.AnnouncementService;
import com.food.service.CategoryService;
import com.food.service.DishService;
import com.food.service.MerchantService;
import com.food.service.OrderService;
import com.food.service.ReviewService;
import com.food.service.StatisticsService;
import com.food.service.UserService;

/** 系统管理员控制器：用户管理、商家审核、订单总览、公告管理、数据统计 */
@WebServlet("/AdminServlet")
public class AdminServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserService userService = new UserService();
    private MerchantService merchantService = new MerchantService();
    private OrderService orderService = new OrderService();
    private AnnouncementService announcementService = new AnnouncementService();
    private CategoryService categoryService = new CategoryService();
    private DishService dishService = new DishService();
    private ReviewService reviewService = new ReviewService();
    private StatisticsService statisticsService = new StatisticsService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("loginUser");
        if (user == null || !"admin".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        if ("index".equals(action) || "dashboard".equals(action)) {
            request.setAttribute("active", "index");
            Map<String, Object> stats = statisticsService.systemStats();
            request.setAttribute("stats", stats);
            request.getRequestDispatcher("/admin/index.jsp").forward(request, response);
            return;
        }

        if ("userList".equals(action)) {
            request.setAttribute("active", "userList");
            String keyword = request.getParameter("keyword");
            String role = request.getParameter("role");
            List<User> users = userService.findAll(keyword, role);
            request.setAttribute("users", users);
            request.setAttribute("keyword", keyword == null ? "" : keyword);
            request.setAttribute("role", role == null ? "" : role);
            request.getRequestDispatcher("/admin/user_list.jsp").forward(request, response);
            return;
        }

        if ("userToggle".equals(action)) {
            Integer id = parseInt(request.getParameter("id"));
            Integer status = parseInt(request.getParameter("status"));
            if (id != null && status != null) userService.updateStatus(id, status);
            response.sendRedirect(request.getContextPath() + "/AdminServlet?action=userList");
            return;
        }

        if ("merchantList".equals(action)) {
            request.setAttribute("active", "merchantList");
            Integer status = parseInt(request.getParameter("status"));
            List<Merchant> merchants = merchantService.findAll(status, null);
            request.setAttribute("merchants", merchants);
            request.setAttribute("currentStatus", status);
            request.getRequestDispatcher("/admin/merchant_list.jsp").forward(request, response);
            return;
        }

        if ("merchantAudit".equals(action)) {
            Integer id = parseInt(request.getParameter("id"));
            Integer status = parseInt(request.getParameter("status")); // 1通过 2驳回
            if (id != null && status != null) merchantService.updateStatus(id, status);
            response.sendRedirect(request.getContextPath() + "/AdminServlet?action=merchantList&status=0");
            return;
        }

        if ("orderList".equals(action)) {
            request.setAttribute("active", "orderList");
            Integer status = parseInt(request.getParameter("status"));
            String keyword = request.getParameter("keyword");
            List<Order> orders = orderService.findAll(status, keyword);
            request.setAttribute("orders", orders);
            request.setAttribute("currentStatus", status);
            request.setAttribute("keyword", keyword == null ? "" : keyword);
            request.getRequestDispatcher("/admin/order_list.jsp").forward(request, response);
            return;
        }

        if ("orderDetail".equals(action)) {
            request.setAttribute("active", "orderList");
            Integer id = parseInt(request.getParameter("id"));
            Order order = orderService.findById(id);
            request.setAttribute("order", order);
            request.getRequestDispatcher("/admin/order_detail.jsp").forward(request, response);
            return;
        }

        if ("dishList".equals(action)) {
            request.setAttribute("active", "dishList");
            List<com.food.entity.Dish> dishes = dishService.findAll(null, null, null, null);
            request.setAttribute("dishes", dishes);
            request.getRequestDispatcher("/admin/dish_list.jsp").forward(request, response);
            return;
        }

        if ("dishToggle".equals(action)) {
            Integer id = parseInt(request.getParameter("id"));
            Integer status = parseInt(request.getParameter("status"));
            if (id != null && status != null) dishService.updateStatus(id, status);
            response.sendRedirect(request.getContextPath() + "/AdminServlet?action=dishList");
            return;
        }

        if ("announcementList".equals(action)) {
            request.setAttribute("active", "announcementList");
            List<Announcement> list = announcementService.findAll();
            request.setAttribute("announcements", list);
            request.getRequestDispatcher("/admin/announcement_list.jsp").forward(request, response);
            return;
        }

        if ("announcementAdd".equals(action)) {
            announcementService.add(request.getParameter("title"), request.getParameter("content"));
            response.sendRedirect(request.getContextPath() + "/AdminServlet?action=announcementList");
            return;
        }

        if ("announcementDelete".equals(action)) {
            Integer id = parseInt(request.getParameter("id"));
            if (id != null) announcementService.delete(id);
            response.sendRedirect(request.getContextPath() + "/AdminServlet?action=announcementList");
            return;
        }

        if ("reviewList".equals(action)) {
            request.setAttribute("active", "reviewList");
            List<Review> reviews = reviewService.findAll();
            request.setAttribute("reviews", reviews);
            request.getRequestDispatcher("/admin/review_list.jsp").forward(request, response);
            return;
        }

        if ("categoryAdd".equals(action)) {
            categoryService.add(request.getParameter("name"), parseInt(request.getParameter("sort")));
            response.sendRedirect(request.getContextPath() + "/AdminServlet?action=categoryList");
            return;
        }

        if ("categoryDelete".equals(action)) {
            Integer id = parseInt(request.getParameter("id"));
            if (id != null) categoryService.delete(id);
            response.sendRedirect(request.getContextPath() + "/AdminServlet?action=categoryList");
            return;
        }

        if ("categoryList".equals(action)) {
            request.setAttribute("active", "categoryList");
            request.setAttribute("categories", categoryService.findAll());
            request.getRequestDispatcher("/admin/category_list.jsp").forward(request, response);
            return;
        }

        response.sendRedirect(request.getContextPath() + "/AdminServlet?action=index");
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
