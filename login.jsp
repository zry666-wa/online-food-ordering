<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户登录 - 网上订餐系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap-icons.min.css?v=20260903b">
</head>
<body class="bg-light d-flex align-items-center" style="min-height:100vh;">
<div class="container" style="max-width: 420px;">
    <div class="text-center mb-4">
        <h3 class="text-danger fw-bold"><i class="bi bi-shop"></i> 网上订餐系统</h3>
        <p class="text-muted">用户登录</p>
    </div>
    <div class="card shadow-sm border-0">
        <div class="card-body p-4">
            <c:if test="${not empty error}">
                <div class="alert alert-danger py-2"><i class="bi bi-exclamation-circle"></i> ${error}</div>
            </c:if>
            <c:if test="${not empty msg}">
                <div class="alert alert-success py-2"><i class="bi bi-check-circle"></i> ${msg}</div>
            </c:if>
            <form action="${pageContext.request.contextPath}/LoginServlet" method="post">
                <div class="mb-3">
                    <label class="form-label">用户名</label>
                    <input type="text" class="form-control" name="username" value="${username}" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">密码</label>
                    <input type="password" class="form-control" name="password" required>
                </div>
                <button type="submit" class="btn btn-danger w-100">登 录</button>
            </form>
            <div class="text-center mt-3 small">
                还没有账号？<a href="register.jsp">立即注册</a>
            </div>
            <hr>
            <div class="small text-muted">
                <p class="mb-1"><strong>演示账号：</strong></p>
                <p class="mb-0">顾客：zhangsan / 123456</p>
                <p class="mb-0">商家：hualixuan / 123456</p>
                <p class="mb-0">管理员：admin / 123456</p>
            </div>
            <div class="text-center mt-3">
                <a href="DishServlet" class="text-decoration-none small"><i class="bi bi-arrow-left"></i> 返回首页</a>
            </div>
        </div>
    </div>
</div>
</body>
</html>
