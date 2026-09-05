<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/header.jsp" %>
<%@ include file="_sidebar.jsp" %>

<div class="col-lg-9">
    <h5 class="fw-bold mb-3"><i class="bi bi-speedometer2 text-danger"></i> 数据总览</h5>
    <div class="row g-3">
        <div class="col-6 col-md-3">
            <div class="card border-0 shadow-sm text-center">
                <div class="card-body">
                    <h3 class="text-primary mb-1">${stats.customerCount}</h3>
                    <div class="text-muted small">注册顾客</div>
                </div>
            </div>
        </div>
        <div class="col-6 col-md-3">
            <div class="card border-0 shadow-sm text-center">
                <div class="card-body">
                    <h3 class="text-danger mb-1">${stats.merchantCount}</h3>
                    <div class="text-muted small">入驻商家</div>
                </div>
            </div>
        </div>
        <div class="col-6 col-md-3">
            <div class="card border-0 shadow-sm text-center">
                <div class="card-body">
                    <h3 class="text-success mb-1">${stats.dishCount}</h3>
                    <div class="text-muted small">菜品总数</div>
                </div>
            </div>
        </div>
        <div class="col-6 col-md-3">
            <div class="card border-0 shadow-sm text-center">
                <div class="card-body">
                    <h3 class="text-warning mb-1">${stats.orderCount}</h3>
                    <div class="text-muted small">订单总数</div>
                </div>
            </div>
        </div>
    </div>
    <div class="row g-3 mt-1">
        <div class="col-md-6">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white fw-bold"><i class="bi bi-check-circle text-success"></i> 已完成订单</div>
                <div class="card-body text-center">
                    <h3 class="text-success mb-0">${stats.finishedCount}</h3>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white fw-bold"><i class="bi bi-cash-coin text-danger"></i> 平台成交总额</div>
                <div class="card-body text-center">
                    <h3 class="text-danger mb-0">¥${stats.totalAmount}</h3>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>
