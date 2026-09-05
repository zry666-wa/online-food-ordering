<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../common/header.jsp" %>
<%@ include file="_sidebar.jsp" %>

<div class="col-lg-9">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h5 class="fw-bold mb-0"><i class="bi bi-receipt text-danger"></i> 订单管理</h5>
    </div>
    <div class="btn-group mb-3" role="group">
        <a href="${ctx}/MerchantServlet?action=orderList" class="btn ${empty currentStatus ? 'btn-danger' : 'btn-outline-danger'} btn-sm">全部</a>
        <a href="${ctx}/MerchantServlet?action=orderList&status=1" class="btn ${currentStatus == 1 ? 'btn-danger' : 'btn-outline-danger'} btn-sm">待接单</a>
        <a href="${ctx}/MerchantServlet?action=orderList&status=2" class="btn ${currentStatus == 2 ? 'btn-danger' : 'btn-outline-danger'} btn-sm">制作中</a>
        <a href="${ctx}/MerchantServlet?action=orderList&status=3" class="btn ${currentStatus == 3 ? 'btn-danger' : 'btn-outline-danger'} btn-sm">配送中</a>
        <a href="${ctx}/MerchantServlet?action=orderList&status=4" class="btn ${currentStatus == 4 ? 'btn-danger' : 'btn-outline-danger'} btn-sm">已完成</a>
    </div>
    <div class="card border-0 shadow-sm">
        <div class="card-body p-0">
            <table class="table table-hover align-middle mb-0">
                <thead><tr><th>订单号</th><th>顾客</th><th>金额</th><th>状态</th><th>下单时间</th><th>操作</th></tr></thead>
                <tbody>
                <c:forEach items="${orders}" var="o">
                    <tr>
                        <td>${o.orderNo}</td>
                        <td>${o.username}</td>
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
                        <td>
                            <a href="${ctx}/MerchantServlet?action=orderDetail&id=${o.id}" class="btn btn-sm btn-outline-primary">详情</a>
                            <c:if test="${o.status == 1 || o.status == 2}">
                                <a href="${ctx}/MerchantServlet?action=orderAdvance&id=${o.id}" class="btn btn-sm btn-danger btn-confirm" data-confirm="确认推进订单状态？">
                                    <c:choose>
                                        <c:when test="${o.status == 1}">接单</c:when>
                                        <c:when test="${o.status == 2}">出餐</c:when>
                                    </c:choose>
                                </a>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>
