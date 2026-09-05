<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="common/header.jsp" %>

<!-- 顶部横幅 -->
<div class="hero-banner mb-4">
    <div class="d-flex justify-content-between align-items-center">
        <div>
            <h1 class="fw-bold mb-2"><i class="bi bi-egg-fried"></i> 美食一键到家</h1>
            <p class="mb-0 fs-5">浏览菜品 · 加入购物车 · 在线下单 · 模拟支付</p>
        </div>
        <c:if test="${not empty announcements}">
            <div class="bg-white text-dark p-3 rounded-3" style="max-width: 340px;">
                <strong><i class="bi bi-megaphone text-danger"></i> 公告</strong>
                <ul class="list-unstyled small mb-0 mt-2">
                    <c:forEach items="${announcements}" var="a" varStatus="st">
                        <c:if test="${st.index < 2}">
                            <li><i class="bi bi-dot"></i>${a.title}</li>
                        </c:if>
                    </c:forEach>
                </ul>
            </div>
        </c:if>
    </div>
</div>

<!-- 分类导航 -->
<div class="mb-4">
    <div class="btn-group flex-wrap" role="group">
        <a href="${ctx}/DishServlet" class="btn ${empty currentCategory ? 'btn-danger' : 'btn-outline-danger'}">全部</a>
        <c:forEach items="${categories}" var="cat">
            <a href="${ctx}/DishServlet?categoryId=${cat.id}"
               class="btn ${currentCategory == cat.id ? 'btn-danger' : 'btn-outline-danger'}">${cat.name}</a>
        </c:forEach>
    </div>
</div>

<!-- 菜品列表 -->
<c:if test="${empty dishes}">
    <div class="text-center text-muted py-5">
        <i class="bi bi-inbox fs-1 d-block mb-2"></i>暂无符合条件的菜品
    </div>
</c:if>
<div class="row g-4">
    <c:forEach items="${dishes}" var="d">
        <div class="col-6 col-md-4 col-lg-3">
            <div class="card dish-card h-100 border-0 shadow-sm">
                <img src="${ctx}/${empty d.image ? 'images/dish/default.jpg' : d.image}" class="card-img-top" alt="${d.name}" onerror="this.src='${ctx}/images/dish/default.jpg'">
                <div class="card-body">
                    <h6 class="card-title mb-1">${d.name}</h6>
                    <p class="card-text small text-muted text-truncate mb-2">${d.shopName} · ${d.categoryName}</p>
                    <div class="d-flex justify-content-between align-items-center">
                        <span class="text-danger fw-bold fs-5">¥${d.price}</span>
                        <span class="text-muted small"><i class="bi bi-fire"></i> 已售${d.sales}</span>
                    </div>
                </div>
                <div class="card-footer bg-white border-0 pb-3">
                    <div class="d-flex gap-2">
                        <a href="${ctx}/DishServlet?action=detail&id=${d.id}" class="btn btn-outline-danger btn-sm flex-fill">查看详情</a>
                        <c:choose>
                            <c:when test="${not empty sessionScope.loginUser && sessionScope.loginUser.role == 'customer'}">
                                <a href="${ctx}/CartServlet?action=add&dishId=${d.id}" class="btn btn-danger btn-sm flex-fill">
                                    <i class="bi bi-cart-plus"></i> 加购
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="${ctx}/login.jsp" class="btn btn-danger btn-sm flex-fill">登录加购</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>
</div>

<%@ include file="common/footer.jsp" %>
