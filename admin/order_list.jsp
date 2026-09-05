<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../common/header.jsp" %>
<%@ include file="_sidebar.jsp" %>

<div class="col-lg-9">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h5 class="fw-bold mb-0"><i class="bi bi-receipt text-danger"></i> 订单管理</h5>
        <form class="d-flex gap-2" action="${ctx}/AdminServlet" method="get">
            <input type="hidden" name="action" value="orderList">
            <select class="form-select form-select-sm" name="status" style="width:120px;">
                <option value="">全部状态</option>
                <option value="0" ${currentStatus == 0 ? 'selected' : ''}>待支付</option>
                <option value="1" ${currentStatus == 1 ? 'selected' : ''}>待接单</option>
                <option value="2" ${currentStatus == 2 ? 'selected' : ''}>制作中</option>
                <option value="3" ${currentStatus == 3 ? 'selected' : ''}>配送中</option>
                <option value="4" ${currentStatus == 4 ? 'selected' : ''}>已完成</option>
                <option value="5" ${currentStatus == 5 ? 'selected' : ''}>已取消</option>
            </select>
            <input type="text" class="form-control form-control-sm" name="keyword" value="${keyword}" placeholder="订单号/用户/商家">
            <button class="btn btn-sm btn-danger">查询</button>
        </form>
    </div>
    <div class="card border-0 shadow-sm">
        <div class="card-body p-0">
            <table class="table table-hover align-middle mb-0">
                <thead><tr><th>订单号</th><th>顾客</th><th>商家</th><th>金额</th><th>状态</th><th>下单时间</th><th>操作</th></tr></thead>
                <tbody>
                <c:forEach items="${orders}" var="o">
                    <tr>
                        <td>${o.orderNo}</td>
                        <td>${o.username}</td>
                        <td>${o.shopName}</td>
                        <td class="text-danger fw-bold">¥${o.totalAmount}</td>
                        <td>
                            <span class="badge
                                <c:choose>
                                    <c:when test="${o.status == 0}">bg-warning text-dark</c:when>
                                    <c:when test="${o.status == 1}">bg-info text-dark</c:when>
                                    <c:when test="${o.status == 2}">bg-primary</c:when>
                                    <c:when test="${o.status == 3}">bg-secondary</c:when>
                                    <c:when test="${o.status == 4}">bg-success</c:when>
                                    <c:otherwise>bg-dark</c:otherwise>
                                </c:choose>">${o.statusText}</span>
                        </td>
                        <td><fmt:formatDate value="${o.createTime}" pattern="MM-dd HH:mm"/></td>
                        <td><a href="${ctx}/AdminServlet?action=orderDetail&id=${o.id}" class="btn btn-sm btn-outline-primary">详情</a></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>
