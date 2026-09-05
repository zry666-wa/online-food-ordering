package com.food.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.food.entity.Category;
import com.food.entity.Dish;
import com.food.entity.Review;
import com.food.service.AnnouncementService;
import com.food.service.CategoryService;
import com.food.service.DishService;
import com.food.service.ReviewService;

/** 菜品浏览控制器：首页列表、按分类/关键词查询、菜品详情 */
@WebServlet("/DishServlet")
public class DishServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DishService dishService = new DishService();
    private CategoryService categoryService = new CategoryService();
    private ReviewService reviewService = new ReviewService();
    private AnnouncementService announcementService = new AnnouncementService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("detail".equals(action)) {
            Integer id = parseInt(request.getParameter("id"));
            Dish dish = dishService.findById(id);
            if (dish == null) {
                response.sendRedirect(request.getContextPath() + "/DishServlet");
                return;
            }
            List<Review> reviews = reviewService.findByDishId(id);
            double avg = reviewService.avgByDish(id);
            request.setAttribute("dish", dish);
            request.setAttribute("reviews", reviews);
            request.setAttribute("avgRating", avg);
            request.getRequestDispatcher("/dish_detail.jsp").forward(request, response);
            return;
        }
        // 首页列表
        Integer categoryId = parseInt(request.getParameter("categoryId"));
        String keyword = request.getParameter("keyword");
        List<Dish> dishes = dishService.findAll(categoryId, null, keyword, 1);
        List<Category> categories = categoryService.findAll();
        request.setAttribute("dishes", dishes);
        request.setAttribute("categories", categories);
        request.setAttribute("announcements", announcementService.findAll());
        request.setAttribute("currentCategory", categoryId);
        request.setAttribute("keyword", keyword == null ? "" : keyword);
        request.getRequestDispatcher("/home.jsp").forward(request, response);
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
