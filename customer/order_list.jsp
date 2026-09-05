<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../common/header.jsp" %>

<div class="card border-0 shadow-sm">
    <div class="card-header bg-white fw-bold"><i class="bi bi-receipt"></i> 我的订单</div>
    <div class="card-body">
        <c:if test="${empty orders}">
            <div class="text-center text-muted py-5">
                <i class="bi bi-inbox fs-1 d-block mb-2"></i>暂无订单，快去点餐吧！
            </div>
        </c:if>
        <c:forEach items="${orders}" var="o">
            <div class="border rounded-3 p-3 mb-3 bg-white">
                <div class="d-flex flex-wrap justify-content-between align-items-center mb-2">
                    <div>
                        <strong>${o.shopName}</strong>
                        <span class="text-muted small ms-2">订单号：${o.orderNo}</span>
                    </div>
                    <div class="d-flex align-items-center gap-2">
                        <c:choose>
                            <c:when test="${o.status == 0}"><span class="badge bg-warning text-dark">待支付</span></c:when>
                            <c:when test="${o.status == 1}"><span class="badge bg-info text-dark">待接单</span></c:when>
                            <c:when test="${o.status == 2}"><span class="badge bg-primary">制作中</span></c:when>
                            <c:when test="${o.status == 3}"><span class="badge bg-secondary">配送中</span></c:when>
                            <c:when test="${o.status == 4}"><span class="badge bg-success">已完成</span></c:when>
                            <c:otherwise><span class="badge bg-dark">已取消</span></c:otherwise>
                        </c:choose>
                        <a href="${ctx}/OrderServlet?action=detail&id=${o.id}" class="btn btn-sm btn-outline-primary">详情</a>
                        <c:if test="${o.status == 0}">
                            <a href="${ctx}/OrderServlet?action=pay&orderNo=${o.orderNo}" class="btn btn-sm btn-danger">支付</a>
                            <a href="${ctx}/OrderServlet?action=cancel&id=${o.id}" class="btn btn-sm btn-outline-danger btn-confirm" data-confirm="确定取消该订单？">取消</a>
                        </c:if>
                        <c:if test="${o.status == 1}">
                            <a href="${ctx}/OrderServlet?action=cancel&id=${o.id}" class="btn btn-sm btn-outline-danger btn-confirm" data-confirm="确定取消该订单？">取消</a>
                        </c:if>
                        <c:if test="${o.status == 3}">
                            <a href="${ctx}/OrderServlet?action=complete&id=${o.id}" class="btn btn-sm btn-success btn-confirm" data-confirm="确认已收到餐品并完成订单？">确认完成</a>
                        </c:if>
                    </div>
                </div>
                <div class="small text-muted">
                    下单时间：<fmt:formatDate value="${o.createTime}" pattern="yyyy-MM-dd HH:mm"/> ·
                    合计：<span class="text-danger fw-bold">¥${o.totalAmount}</span>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>
