<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String ctx = request.getContextPath();
    request.setAttribute("ctx", ctx);
    // 默认标题
    if (request.getAttribute("pageTitle") == null) {
        request.setAttribute("pageTitle", "网上订餐系统");
    }
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle}</title>
    <link rel="stylesheet" href="${ctx}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctx}/css/bootstrap-icons.min.css?v=20260903b">
    <link rel="stylesheet" href="${ctx}/css/style.css">
</head>
<body class="bg-light">
<script src="${ctx}/js/jquery-3.7.1.min.js"></script>
<script src="${ctx}/js/bootstrap.bundle.min.js"></script>
<script src="${ctx}/js/common.js"></script>
<nav class="navbar navbar-expand-lg navbar-dark bg-danger shadow-sm">
    <div class="container">
        <a class="navbar-brand fw-bold" href="${ctx}/DishServlet">
            <i class="bi bi-shop"></i> 网上订餐系统
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navMain">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navMain">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="${ctx}/DishServlet">首页</a></li>
                <li class="nav-item"><a class="nav-link" href="${ctx}/DishServlet?categoryId=1">热销推荐</a></li>
                <li class="nav-item"><a class="nav-link" href="${ctx}/DishServlet?categoryId=2">家常菜</a></li>
                <li class="nav-item"><a class="nav-link" href="${ctx}/DishServlet?categoryId=3">川湘菜</a></li>
                <li class="nav-item"><a class="nav-link" href="${ctx}/DishServlet?categoryId=4">特色小吃</a></li>
                <li class="nav-item"><a class="nav-link" href="${ctx}/DishServlet?categoryId=5">饮品甜点</a></li>
                <li class="nav-item"><a class="nav-link" href="${ctx}/DishServlet?categoryId=6">商务套餐</a></li>
            </ul>
            <form class="d-flex me-2" action="${ctx}/DishServlet" method="get">
                <input class="form-control form-control-sm me-2" type="search" name="keyword" placeholder="搜索菜品/商家" value="${keyword}">
                <button class="btn btn-warning btn-sm" type="submit"><i class="bi bi-search"></i> 搜索</button>
            </form>
            <c:choose>
                <c:when test="${empty sessionScope.loginUser}">
                    <a class="btn btn-outline-light btn-sm me-2" href="${ctx}/login.jsp">登录</a>
                    <a class="btn btn-light btn-sm" href="${ctx}/register.jsp">注册</a>
                </c:when>
                <c:otherwise>
                    <c:if test="${sessionScope.loginUser.role == 'customer'}">
                        <a class="btn btn-outline-light btn-sm me-2" href="${ctx}/CartServlet">
                            <i class="bi bi-cart3"></i> 购物车
                        </a>
                        <a class="btn btn-outline-light btn-sm me-2" href="${ctx}/OrderServlet?action=list">我的订单</a>
                    </c:if>
                    <c:if test="${sessionScope.loginUser.role == 'merchant'}">
                        <a class="btn btn-outline-light btn-sm me-2" href="${ctx}/MerchantServlet?action=dashboard">
                            <i class="bi bi-shop-window"></i> 商家中心
                        </a>
                    </c:if>
                    <c:if test="${sessionScope.loginUser.role == 'admin'}">
                        <a class="btn btn-outline-light btn-sm me-2" href="${ctx}/AdminServlet?action=index">
                            <i class="bi bi-gear"></i> 管理后台
                        </a>
                    </c:if>
                    <span class="navbar-text text-white me-2">
                        <i class="bi bi-person-circle"></i> ${sessionScope.loginUser.realName != '' ? sessionScope.loginUser.realName : sessionScope.loginUser.username}
                    </span>
                    <a class="btn btn-danger btn-sm" href="${ctx}/LoginServlet?action=logout">退出</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</nav>
<main class="container py-4">
