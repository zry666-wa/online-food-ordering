<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/header.jsp" %>

<div class="row">
    <div class="col-lg-4 mb-4">
        <div class="card border-0 shadow-sm text-center">
            <div class="card-body">
                <i class="bi bi-person-circle text-danger" style="font-size:4rem;"></i>
                <h5 class="mt-2">${sessionScope.loginUser.realName != '' ? sessionScope.loginUser.realName : sessionScope.loginUser.username}</h5>
                <p class="text-muted small mb-1">用户名：${sessionScope.loginUser.username}</p>
                <p class="text-muted small mb-1">角色：
                    <c:choose>
                        <c:when test="${sessionScope.loginUser.role == 'admin'}">系统管理员</c:when>
                        <c:when test="${sessionScope.loginUser.role == 'merchant'}">商家</c:when>
                        <c:otherwise>顾客</c:otherwise>
                    </c:choose>
                </p>
            </div>
        </div>
    </div>
    <div class="col-lg-8">
        <c:if test="${not empty msg}"><div class="alert alert-success py-2">${msg}</div></c:if>
        <c:if test="${not empty error}"><div class="alert alert-danger py-2">${error}</div></c:if>
        <div class="card border-0 shadow-sm mb-4">
            <div class="card-header bg-white fw-bold"><i class="bi bi-person-lines-fill"></i> 基本资料</div>
            <div class="card-body">
                <form action="${ctx}/UserServlet" method="post">
                    <input type="hidden" name="action" value="updateProfile">
                    <div class="mb-3">
                        <label class="form-label">用户名</label>
                        <input type="text" class="form-control" value="${sessionScope.loginUser.username}" disabled>
                    </div>
                    <div class="row">
                        <div class="col mb-3">
                            <label class="form-label">真实姓名</label>
                            <input type="text" class="form-control" name="realName" value="${sessionScope.loginUser.realName}">
                        </div>
                        <div class="col mb-3">
                            <label class="form-label">手机号</label>
                            <input type="text" class="form-control" name="phone" value="${sessionScope.loginUser.phone}">
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">邮箱</label>
                        <input type="email" class="form-control" name="email" value="${sessionScope.loginUser.email}">
                    </div>
                    <button type="submit" class="btn btn-danger">保存资料</button>
                </form>
            </div>
        </div>
        <div class="card border-0 shadow-sm">
            <div class="card-header bg-white fw-bold"><i class="bi bi-shield-lock"></i> 修改密码</div>
            <div class="card-body">
                <form action="${ctx}/UserServlet" method="post">
                    <input type="hidden" name="action" value="changePassword">
                    <div class="mb-3">
                        <label class="form-label">原密码</label>
                        <input type="password" class="form-control" name="oldPassword" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">新密码</label>
                        <input type="password" class="form-control" name="newPassword" minlength="6" required>
                    </div>
                    <button type="submit" class="btn btn-outline-danger">修改密码</button>
                </form>
            </div>
        </div>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>
