package com.food.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * 登录拦截过滤器：保护需要登录的请求。
 * 未登录用户访问受保护路径时跳转到登录页。
 */
public class LoginFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;
        String uri = request.getRequestURI();

        // 静态资源与公开页面直接放行
        if (uri.endsWith(".css") || uri.endsWith(".js") || uri.endsWith(".jpg")
                || uri.endsWith(".png") || uri.endsWith(".gif") || uri.endsWith(".ico")
                || uri.endsWith(".woff") || uri.endsWith(".woff2") || uri.endsWith(".ttf")
                || uri.endsWith(".eot") || uri.endsWith(".svg")
                || uri.endsWith("login.jsp") || uri.endsWith("register.jsp")
                || uri.contains("LoginServlet") || uri.contains("RegisterServlet")
                || uri.endsWith("index.jsp") || uri.equals("/") || uri.endsWith("/")
                || uri.contains("DishServlet") || uri.contains("AnnouncementServlet")
                || uri.contains("CategoryServlet") || uri.contains("ReviewServlet")) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loginUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {}
}
