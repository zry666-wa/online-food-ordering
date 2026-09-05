<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../common/header.jsp" %>
<%@ include file="_sidebar.jsp" %>

<div class="col-lg-9">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h5 class="fw-bold mb-0"><i class="bi bi-speedometer2 text-danger"></i> 经营看板</h5>
    </div>
    <div class="row g-3 mb-4">
        <div class="col-6 col-md-3">
            <div class="card border-0 shadow-sm text-center">
                <div class="card-body">
                    <h3 class="text-primary mb-1">${stats.orderCount}</h3>
                    <div class="text-muted small">总订单</div>
                </div>
            </div>
        </div>
        <div class="col-6 col-md-3">
            <div class="card border-0 shadow-sm text-center">
                <div class="card-body">
                    <h3 class="text-danger mb-1">¥${stats.totalAmount}</h3>
                    <div class="text-muted small">已完成销售额</div>
                </div>
            </div>
        </div>
        <div class="col-6 col-md-3">
            <div class="card border-0 shadow-sm text-center">
                <div class="card-body">
                    <h3 class="text-warning mb-1">${stats.pendingCount}</h3>
                    <div class="text-muted small">待接单</div>
                </div>
            </div>
        </div>
        <div class="col-6 col-md-3">
            <div class="card border-0 shadow-sm text-center">
                <div class="card-body">
                    <h3 class="text-success mb-1">${stats.avgRating}</h3>
                    <div class="text-muted small">平均评分</div>
                </div>
            </div>
        </div>
    </div>
    <div class="card border-0 shadow-sm">
        <div class="card-header bg-white fw-bold"><i class="bi bi-fire text-danger"></i> 热销菜品 Top5</div>
        <div class="card-body p-0">
            <table class="table table-hover mb-0">
                <thead><tr><th>#</th><th>菜品</th><th>价格</th><th>销量</th><th>状态</th></tr></thead>
                <tbody>
                <c:forEach items="${stats.hotDishes}" var="d" varStatus="st">
                    <tr>
                        <td>${st.index + 1}</td>
                        <td>${d.name}</td>
                        <td>¥${d.price}</td>
                        <td>${d.sales}</td>
                        <td>
                            <span class="badge ${d.status == 1 ? 'bg-success' : 'bg-secondary'}">${d.status == 1 ? '在售' : '已下架'}</span>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>
