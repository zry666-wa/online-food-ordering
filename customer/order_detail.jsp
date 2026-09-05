<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../common/header.jsp" %>

<div class="card border-0 shadow-sm">
    <div class="card-header bg-white d-flex justify-content-between align-items-center">
        <span class="fw-bold"><i class="bi bi-receipt"></i> 订单详情</span>
        <a href="${ctx}/OrderServlet?action=list" class="btn btn-sm btn-outline-secondary">返回列表</a>
    </div>
    <div class="card-body">
        <div class="mb-3">
            <h5 class="mb-1">${order.shopName}</h5>
            <span class="badge
                <c:choose>
                    <c:when test="${order.status == 0}">bg-warning text-dark</c:when>
                    <c:when test="${order.status == 1}">bg-info text-dark</c:when>
                    <c:when test="${order.status == 2}">bg-primary</c:when>
                    <c:when test="${order.status == 3}">bg-secondary</c:when>
                    <c:when test="${order.status == 4}">bg-success</c:when>
                    <c:otherwise>bg-dark</c:otherwise>
                </c:choose>">${order.statusText}</span>
            <div class="small text-muted mt-1">订单号：${order.orderNo} · 下单时间：<fmt:formatDate value="${order.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
        </div>
        <table class="table align-middle">
            <thead><tr><th>菜品</th><th>单价</th><th>数量</th><th>小计</th><th>评价</th></tr></thead>
            <tbody>
            <c:forEach items="${order.items}" var="it">
                <tr>
                    <td>${it.dishName}</td>
                    <td>¥${it.price}</td>
                    <td>${it.quantity}</td>
                    <td class="text-danger">¥${it.subtotal}</td>
                    <td>
                        <c:if test="${order.status == 4}">
                            <button type="button" class="btn btn-sm btn-outline-warning" data-bs-toggle="modal" data-bs-target="#reviewModal"
                                    data-order="${order.id}" data-dish="${it.dishId}" data-dishname="${it.dishName}">评价</button>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <div class="row small">
            <div class="col-md-6">
                <p class="mb-1"><strong>配送地址：</strong>${order.address}</p>
                <p class="mb-1"><strong>联系电话：</strong>${order.phone}</p>
                <p class="mb-1"><strong>备注：</strong>${empty order.remark ? '无' : order.remark}</p>
            </div>
            <div class="col-md-6 text-md-end">
                <p class="mb-1"><strong>支付时间：</strong><fmt:formatDate value="${order.payTime}" pattern="yyyy-MM-dd HH:mm"/></p>
                <p class="mb-1"><strong>完成时间：</strong><fmt:formatDate value="${order.finishTime}" pattern="yyyy-MM-dd HH:mm"/></p>
                <h5 class="mb-0 mt-2">合计：<span class="text-danger">¥${order.totalAmount}</span></h5>
            </div>
        </div>
        <div class="mt-3">
            <c:if test="${order.status == 0}">
                <a href="${ctx}/OrderServlet?action=pay&orderNo=${order.orderNo}" class="btn btn-danger">立即支付（模拟）</a>
                <a href="${ctx}/OrderServlet?action=cancel&id=${order.id}" class="btn btn-outline-danger btn-confirm" data-confirm="确定取消该订单？">取消订单</a>
            </c:if>
            <c:if test="${order.status == 3}">
                <a href="${ctx}/OrderServlet?action=complete&id=${order.id}" class="btn btn-success btn-confirm" data-confirm="确认已收到餐品并完成订单？"><i class="bi bi-check2-circle"></i> 确认完成</a>
            </c:if>
        </div>
    </div>
</div>

<!-- 评价弹窗 -->
<div class="modal fade" id="reviewModal" tabindex="-1">
    <div class="modal-dialog">
        <form class="modal-content" action="${ctx}/ReviewServlet" method="post">
            <input type="hidden" name="orderId" id="reviewOrderId">
            <input type="hidden" name="dishId" id="reviewDishId">
            <div class="modal-header">
                <h6 class="modal-title">评价菜品 - <span id="reviewDishName"></span></h6>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="mb-3">
                    <label class="form-label d-block">评分</label>
                    <div class="btn-group" role="group">
                        <c:forEach begin="1" end="5" var="i">
                            <input type="radio" class="btn-check" name="rating" id="star${i}" value="${i}" ${i == 5 ? 'checked' : ''}>
                            <label class="btn btn-outline-warning" for="star${i}">${i}星</label>
                        </c:forEach>
                    </div>
                </div>
                <div class="mb-2">
                    <label class="form-label">评价内容</label>
                    <textarea class="form-control" name="content" rows="3"></textarea>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
                <button type="submit" class="btn btn-warning">提交评价</button>
            </div>
        </form>
    </div>
</div>

<script>
$(function () {
    $('#reviewModal').on('show.bs.modal', function (e) {
        var btn = $(e.relatedTarget);
        $('#reviewOrderId').val(btn.data('order'));
        $('#reviewDishId').val(btn.data('dish'));
        $('#reviewDishName').text(btn.data('dishname'));
    });
});
</script>
<%@ include file="../common/footer.jsp" %>
