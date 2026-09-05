<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="common/header.jsp" %>

<div class="row">
    <div class="col-lg-8">
        <div class="card border-0 shadow-sm">
            <div class="card-body p-4">
                <div class="row">
                    <div class="col-md-5 mb-3">
                        <img src="${ctx}/${empty dish.image ? 'images/dish/default.jpg' : dish.image}" class="img-fluid rounded-3" alt="${dish.name}" onerror="this.src='${ctx}/images/dish/default.jpg'">
                    </div>
                    <div class="col-md-7">
                        <h4 class="fw-bold mb-2">${dish.name}</h4>
                        <p class="text-muted mb-1"><i class="bi bi-shop"></i> ${dish.shopName}</p>
                        <p class="text-muted mb-1"><i class="bi bi-tags"></i> ${dish.categoryName}</p>
                        <p class="text-muted"><i class="bi bi-fire"></i> 已售 ${dish.sales} 份</p>
                        <h3 class="text-danger fw-bold mb-3">¥${dish.price}</h3>
                        <c:choose>
                            <c:when test="${not empty sessionScope.loginUser && sessionScope.loginUser.role == 'customer'}">
                                <a href="${ctx}/CartServlet?action=add&dishId=${dish.id}" class="btn btn-danger px-4"><i class="bi bi-cart-plus"></i> 加入购物车</a>
                            </c:when>
                            <c:otherwise>
                                <a href="${ctx}/login.jsp" class="btn btn-danger px-4">登录后加购</a>
                            </c:otherwise>
                        </c:choose>
                        <a href="${ctx}/DishServlet" class="btn btn-outline-secondary px-4">继续逛</a>
                    </div>
                </div>
                <hr>
                <h6 class="fw-bold">菜品描述</h6>
                <p class="text-muted">${empty dish.description ? '暂无描述' : dish.description}</p>
                <hr>
                <h6 class="fw-bold"><i class="bi bi-star-fill text-warning"></i> 用户评价
                    <span class="badge bg-warning text-dark">${avgRating} 分</span></h6>
                <c:if test="${empty reviews}">
                    <p class="text-muted small">暂无评价</p>
                </c:if>
                <c:forEach items="${reviews}" var="r">
                    <div class="border rounded-3 p-3 mb-2 bg-white">
                        <div class="d-flex justify-content-between">
                            <strong class="small">${r.username}</strong>
                            <span class="text-warning small">
                                <c:forEach begin="1" end="${r.rating}"><i class="bi bi-star-fill"></i></c:forEach>
                            </span>
                        </div>
                        <p class="mb-0 small text-muted mt-1">${r.content}</p>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
    <div class="col-lg-4">
        <div class="card border-0 shadow-sm mb-3">
            <div class="card-header bg-white fw-bold"><i class="bi bi-bullhorn text-danger"></i> 平台公告</div>
            <div class="card-body small">
                <c:if test="${empty announcements}">暂无公告</c:if>
                <c:forEach items="${announcements}" var="a">
                    <div class="mb-2">
                        <strong>${a.title}</strong>
                        <p class="text-muted mb-0">${a.content}</p>
                    </div>
                </c:forEach>
            </div>
        </div>
        <div class="card border-0 shadow-sm">
            <div class="card-header bg-white fw-bold"><i class="bi bi-info-circle text-primary"></i> 订餐流程</div>
            <div class="card-body small">
                <ol class="mb-0 ps-3">
                    <li>注册/登录账号</li>
                    <li>浏览并选择菜品</li>
                    <li>加入购物车结算</li>
                    <li>填写配送信息提交订单</li>
                    <li>模拟支付，等待商家接单</li>
                    <li>商家制作/配送/完成</li>
                    <li>对菜品进行评价</li>
                </ol>
            </div>
        </div>
    </div>
</div>

<%@ include file="common/footer.jsp" %>
