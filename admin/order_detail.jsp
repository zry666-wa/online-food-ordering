<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../common/header.jsp" %>
<%@ include file="_sidebar.jsp" %>

<div class="col-lg-9">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h5 class="fw-bold mb-0"><i class="bi bi-receipt text-danger"></i> 订单详情</h5>
        <a href="${ctx}/AdminServlet?action=orderList" class="btn btn-outline-secondary btn-sm">返回</a>
    </div>
    <div class="card border-0 shadow-sm">
        <div class="card-body">
            <h6>订单号：${order.orderNo}
                <span class="badge
                    <c:choose>
                        <c:when test="${order.status == 0}">bg-warning text-dark</c:when>
                        <c:when test="${order.status == 1}">bg-info text-dark</c:when>
                        <c:when test="${order.status == 2}">bg-primary</c:when>
                        <c:when test="${order.status == 3}">bg-secondary</c:when>
                        <c:when test="${order.status == 4}">bg-success</c:when>
                        <c:otherwise>bg-dark</c:otherwise>
                    </c:choose>">${order.statusText}</span>
            </h6>
            <div class="row small mb-3">
                <div class="col-md-4">顾客：${order.username}</div>
                <div class="col-md-4">商家：${order.shopName}</div>
                <div class="col-md-4">联系电话：${order.phone}</div>
                <div class="col-md-4 mt-2">配送地址：${order.address}</div>
                <div class="col-md-4 mt-2">下单时间：<fmt:formatDate value="${order.createTime}" pattern="yyyy-MM-dd HH:mm"/></div>
                <div class="col-md-4 mt-2">备注：${empty order.remark ? '无' : order.remark}</div>
            </div>
            <table class="table align-middle">
                <thead><tr><th>菜品</th><th>单价</th><th>数量</th><th>小计</th></tr></thead>
                <tbody>
                <c:forEach items="${order.items}" var="it">
                    <tr>
                        <td>${it.dishName}</td>
                        <td>¥${it.price}</td>
                        <td>${it.quantity}</td>
                        <td class="text-danger">¥${it.subtotal}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <div class="text-end"><h5>合计：<span class="text-danger">¥${order.totalAmount}</span></h5></div>
        </div>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>
