<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/header.jsp" %>

<div class="card border-0 shadow-sm">
    <div class="card-header bg-white fw-bold"><i class="bi bi-clipboard-check"></i> 确认订单</div>
    <div class="card-body">
        <c:if test="${not empty error}">
            <div class="alert alert-danger py-2">${error}</div>
        </c:if>
        <c:if test="${empty cartItems}">
            <div class="text-center text-muted py-5">
                <i class="bi bi-cart-x fs-1 d-block mb-2"></i>购物车为空，无法下单
                <div class="mt-3"><a href="${ctx}/DishServlet" class="btn btn-danger">去点餐</a></div>
            </div>
        </c:if>
        <c:if test="${not empty cartItems}">
            <div class="row">
                <div class="col-lg-7">
                    <h6 class="fw-bold mb-3">订单商品</h6>
                    <table class="table align-middle">
                        <thead><tr><th>菜品</th><th>单价</th><th>数量</th><th>小计</th></tr></thead>
                        <tbody>
                        <c:forEach items="${cartItems}" var="c">
                            <tr>
                                <td>
                                    <img src="${ctx}/${empty c.image ? 'images/dish/default.jpg' : c.image}" width="40" height="40" class="rounded-3 me-2" alt="" onerror="this.src='${ctx}/images/dish/default.jpg'">
                                    ${c.dishName} <span class="small text-muted">(${c.shopName})</span>
                                </td>
                                <td>¥${c.price}</td>
                                <td>${c.quantity}</td>
                                <td class="text-danger">¥${c.subtotal}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <div class="text-end fw-bold mb-3">订单合计：<span class="text-danger fs-5">¥${total}</span></div>
                </div>
                <div class="col-lg-5">
                    <h6 class="fw-bold mb-3">配送信息</h6>
                    <form action="${ctx}/OrderServlet" method="get">
                        <input type="hidden" name="action" value="submit">
                        <div class="mb-3">
                            <label class="form-label">配送地址 <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="address" required placeholder="请输入详细配送地址">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">联系电话 <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="phone" value="${sessionScope.loginUser.phone}" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">备注</label>
                            <textarea class="form-control" name="remark" rows="2" placeholder="口味偏好、送达时间等"></textarea>
                        </div>
                        <button type="submit" class="btn btn-danger w-100 btn-confirm" data-confirm="确认提交订单？">提交订单</button>
                    </form>
                </div>
            </div>
        </c:if>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>
