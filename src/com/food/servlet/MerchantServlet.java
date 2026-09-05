package com.food.servlet;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.food.entity.Dish;
import com.food.entity.Merchant;
import com.food.entity.Order;
import com.food.entity.Review;
import com.food.entity.User;
import com.food.service.CategoryService;
import com.food.service.DishService;
import com.food.service.MerchantService;
import com.food.service.OrderService;
import com.food.service.ReviewService;
import com.food.service.StatisticsService;

/** 商家端控制器：经营看板、菜品管理、订单处理、评价查看 */
@WebServlet("/MerchantServlet")
public class MerchantServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private MerchantService merchantService = new MerchantService();
    private DishService dishService = new DishService();
    private CategoryService categoryService = new CategoryService();
    private OrderService orderService = new OrderService();
    private ReviewService reviewService = new ReviewService();
    private StatisticsService statisticsService = new StatisticsService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("loginUser");
        if (user == null || !"merchant".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        Merchant merchant = merchantService.findByUserId(user.getId());
        if (merchant == null) {
            response.sendRedirect(request.getContextPath() + "/DishServlet");
            return;
        }
        request.setAttribute("merchant", merchant);
        // 判断审核状态
        if (merchant.getStatus() != 1) {
            request.getRequestDispatcher("/merchant/pending.jsp").forward(request, response);
            return;
        }

        if ("dashboard".equals(action)) {
            request.setAttribute("active", "dashboard");
            Map<String, Object> stats = statisticsService.merchantStats(merchant.getId());
            request.setAttribute("stats", stats);
            request.getRequestDispatcher("/merchant/dashboard.jsp").forward(request, response);
            return;
        }

        if ("dishList".equals(action)) {
            request.setAttribute("active", "dishList");
            List<Dish> dishes = dishService.findAll(null, merchant.getId(), null, null);
            request.setAttribute("dishes", dishes);
            request.setAttribute("categories", categoryService.findAll());
            request.getRequestDispatcher("/merchant/dish_list.jsp").forward(request, response);
            return;
        }

        if ("dishEdit".equals(action)) {
            request.setAttribute("active", "dishList");
            Integer id = parseInt(request.getParameter("id"));
            if (id != null) {
                Dish dish = dishService.findById(id);
                if (dish != null && dish.getMerchantId().equals(merchant.getId())) {
                    request.setAttribute("dish", dish);
                }
            }
            request.setAttribute("categories", categoryService.findAll());
            request.getRequestDispatcher("/merchant/dish_edit.jsp").forward(request, response);
            return;
        }

        if ("dishSave".equals(action)) {
            saveDish(request, merchant);
            response.sendRedirect(request.getContextPath() + "/MerchantServlet?action=dishList");
            return;
        }

        if ("dishDelete".equals(action)) {
            Integer id = parseInt(request.getParameter("id"));
            if (id != null) {
                Dish d = dishService.findById(id);
                if (d != null && d.getMerchantId().equals(merchant.getId())) dishService.delete(id);
            }
            response.sendRedirect(request.getContextPath() + "/MerchantServlet?action=dishList");
            return;
        }

        if ("dishToggle".equals(action)) {
            Integer id = parseInt(request.getParameter("id"));
            if (id != null) {
                Dish d = dishService.findById(id);
                if (d != null && d.getMerchantId().equals(merchant.getId())) {
                    dishService.updateStatus(id, d.getStatus() == 1 ? 0 : 1);
                }
            }
            response.sendRedirect(request.getContextPath() + "/MerchantServlet?action=dishList");
            return;
        }

        if ("orderList".equals(action)) {
            request.setAttribute("active", "orderList");
            Integer status = parseInt(request.getParameter("status"));
            List<Order> orders = orderService.findByMerchantId(merchant.getId(), status);
            request.setAttribute("orders", orders);
            request.setAttribute("currentStatus", status);
            request.getRequestDispatcher("/merchant/order_list.jsp").forward(request, response);
            return;
        }

        if ("orderDetail".equals(action)) {
            request.setAttribute("active", "orderList");
            Integer id = parseInt(request.getParameter("id"));
            Order order = orderService.findById(id);
            if (order == null || !order.getMerchantId().equals(merchant.getId())) {
                response.sendRedirect(request.getContextPath() + "/MerchantServlet?action=orderList");
                return;
            }
            request.setAttribute("order", order);
            request.getRequestDispatcher("/merchant/order_detail.jsp").forward(request, response);
            return;
        }

        if ("orderAdvance".equals(action)) {
            Integer id = parseInt(request.getParameter("id"));
            if (id != null) orderService.merchantAdvance(id, merchant.getId());
            response.sendRedirect(request.getContextPath() + "/MerchantServlet?action=orderList");
            return;
        }

        if ("reviews".equals(action)) {
            request.setAttribute("active", "reviews");
            List<Review> reviews = reviewService.findByMerchantId(merchant.getId());
            request.setAttribute("reviews", reviews);
            request.getRequestDispatcher("/merchant/reviews.jsp").forward(request, response);
            return;
        }

        if ("profile".equals(action)) {
            request.setAttribute("active", "profile");
            request.getRequestDispatcher("/merchant/profile.jsp").forward(request, response);
            return;
        }

        if ("profileSave".equals(action)) {
            merchant.setShopName(request.getParameter("shopName"));
            merchant.setShopDesc(request.getParameter("shopDesc"));
            merchant.setAddress(request.getParameter("address"));
            merchant.setLicenseNo(request.getParameter("licenseNo"));
            merchantService.update(merchant);
            request.setAttribute("merchant", merchantService.findById(merchant.getId()));
            request.setAttribute("msg", "店铺资料已保存");
            request.getRequestDispatcher("/merchant/profile.jsp").forward(request, response);
            return;
        }

        response.sendRedirect(request.getContextPath() + "/MerchantServlet?action=dashboard");
    }

    private void saveDish(HttpServletRequest request, Merchant merchant) {
        String idStr = request.getParameter("id");
        Dish dish;
        boolean isNew = (idStr == null || idStr.isEmpty());
        if (isNew) {
            dish = new Dish();
            dish.setMerchantId(merchant.getId());
        } else {
            Integer id = parseInt(idStr);
            dish = dishService.findById(id);
            if (dish == null || !dish.getMerchantId().equals(merchant.getId())) return;
        }
        dish.setName(request.getParameter("name"));
        dish.setCategoryId(parseInt(request.getParameter("categoryId")));
        dish.setDescription(request.getParameter("description"));
        dish.setPrice(new BigDecimal(request.getParameter("price")));
        String image = request.getParameter("image");
        dish.setImage(image == null || image.trim().isEmpty() ? "images/dish/default.jpg" : image.trim());
        if (isNew) {
            dish.setStatus(1);
            dishService.add(dish);
        } else {
            dishService.update(dish);
        }
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
