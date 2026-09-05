<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/header.jsp" %>

<div class="text-center py-5">
    <i class="bi bi-check-circle-fill text-success" style="font-size:4rem;"></i>
    <h3 class="mt-3 fw-bold">${msg}</h3>
    <p class="text-muted">订单编号：<strong class="text-danger">${orderNo}</strong></p>
    <p class="text-muted">当前状态：待支付，请尽快完成支付，商家接单后开始制作。</p>
    <div class="mt-4">
        <a href="${ctx}/OrderServlet?action=pay&orderNo=${orderNo}" class="btn btn-danger btn-lg px-4 btn-confirm" data-confirm="确认支付该订单？">
            <i class="bi bi-credit-card"></i> 立即支付（模拟）
        </a>
        <a href="${ctx}/OrderServlet?action=list" class="btn btn-outline-secondary btn-lg px-4 ms-2">稍后支付 · 查看订单</a>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>
