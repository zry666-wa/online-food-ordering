<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户注册 - 网上订餐系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap-icons.min.css?v=20260903b">
</head>
<body class="bg-light py-4">
<div class="container" style="max-width: 560px;">
    <div class="text-center mb-3">
        <h4 class="text-danger fw-bold"><i class="bi bi-shop"></i> 网上订餐系统</h4>
        <p class="text-muted">用户注册</p>
    </div>
    <div class="card shadow-sm border-0">
        <div class="card-body p-4">
            <c:if test="${not empty error}">
                <div class="alert alert-danger py-2"><i class="bi bi-exclamation-circle"></i> ${error}</div>
            </c:if>
            <ul class="nav nav-pills nav-justified mb-4">
                <li class="nav-item">
                    <a class="nav-link ${empty type || type == 'customer' ? 'active bg-danger' : 'text-danger'}" href="#" data-type="customer">顾客注册</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${type == 'merchant' ? 'active bg-danger' : 'text-danger'}" href="#" data-type="merchant">商家入驻</a>
                </li>
            </ul>
            <form action="${pageContext.request.contextPath}/RegisterServlet" method="post">
                <input type="hidden" name="type" id="regType" value="${empty type ? 'customer' : type}">
                <div class="mb-3">
                    <label class="form-label">用户名 <span class="text-danger">*</span></label>
                    <input type="text" class="form-control" name="username" required>
                    <div class="form-text">用户名无格式限制，但不能与已有用户名重复</div>
                </div>
                <div class="row">
                    <div class="col mb-3">
                        <label class="form-label">密码 <span class="text-danger">*</span></label>
                        <input type="password" class="form-control" name="password" pattern="(?=.*[a-z])(?=.*[A-Z])(?=.*\d).*" required>
                    </div>
                    <div class="col mb-3">
                        <label class="form-label">确认密码 <span class="text-danger">*</span></label>
                        <input type="password" class="form-control" name="confirmPassword" required>
                    </div>
                </div>
                <div class="mb-3 text-muted small">
                    <i class="bi bi-shield-lock"></i> 密码必须同时包含大写字母、小写字母和数字
                </div>
                <div class="mb-3">
                    <label class="form-label">真实姓名</label>
                    <input type="text" class="form-control" name="realName">
                </div>
                <div class="mb-3">
                    <label class="form-label">手机号</label>
                    <input type="text" class="form-control" name="phone">
                </div>
                <div class="mb-3">
                    <label class="form-label">邮箱</label>
                    <input type="email" class="form-control" name="email">
                </div>
                <!-- 商家专属信息 -->
                <div id="merchantFields" style="${type == 'merchant' ? '' : 'display:none;'}">
                    <hr>
                    <h6 class="text-danger">店铺信息</h6>
                    <div class="mb-3">
                        <label class="form-label">店铺名称 <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" name="shopName">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">店铺简介</label>
                        <textarea class="form-control" name="shopDesc" rows="2"></textarea>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">店铺地址</label>
                        <input type="text" class="form-control" name="address">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">营业执照号</label>
                        <input type="text" class="form-control" name="licenseNo">
                    </div>
                </div>
                <button type="submit" class="btn btn-danger w-100">注 册</button>
            </form>
            <div class="text-center mt-3 small">
                已有账号？<a href="login.jsp">去登录</a> ·
                <a href="DishServlet" class="text-decoration-none">返回首页</a>
            </div>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script>
    $(function () {
        $('.nav-pills a').on('click', function () {
            var t = $(this).data('type');
            $('#regType').val(t);
            $('.nav-pills a').removeClass('active bg-danger').addClass('text-danger');
            $(this).addClass('active bg-danger').removeClass('text-danger');
            if (t === 'merchant') {
                $('#merchantFields').show();
                $('input[name="shopName"]').prop('required', true);
            } else {
                $('#merchantFields').hide();
                $('input[name="shopName"]').prop('required', false);
            }
        });
    });
</script>
</body>
</html>
