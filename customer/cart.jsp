<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/header.jsp" %>

<div class="card border-0 shadow-sm">
    <div class="card-header bg-white fw-bold"><i class="bi bi-cart3"></i> 我的购物车</div>
    <div class="card-body">
        <c:if test="${not empty error}">
            <div class="alert alert-danger py-2">${error}</div>
        </c:if>
        <c:if test="${empty cartItems}">
            <div class="text-center text-muted py-5">
                <i class="bi bi-cart-x fs-1 d-block mb-2"></i>购物车还是空的，去逛逛吧！
                <div class="mt-3"><a href="${ctx}/DishServlet" class="btn btn-danger">去点餐</a></div>
            </div>
        </c:if>
        <c:if test="${not empty cartItems}">
            <table class="table align-middle">
                <thead>
                <tr>
                    <th>菜品</th><th>单价</th><th>数量</th><th>小计</th><th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${cartItems}" var="c">
                    <tr>
                        <td>
                            <img src="${ctx}/${empty c.image ? 'images/dish/default.jpg' : c.image}" width="48" height="48" class="rounded-3 me-2" alt="" onerror="this.src='${ctx}/images/dish/default.jpg'">
                            <strong>${c.dishName}</strong>
                            <div class="small text-muted">${c.shopName}</div>
                        </td>
                        <td>¥${c.price}</td>
                        <td>
                            <form class="d-flex align-items-center gap-2" action="${ctx}/CartServlet" method="get">
                                <input type="hidden" name="action" value="updateQty">
                                <input type="hidden" name="id" value="${c.id}">
                                <button type="button" class="btn btn-sm btn-outline-secondary btn-minus" data-id="${c.id}">-</button>
                                <input type="number" name="quantity" class="form-control form-control-sm text-center" style="width:70px;" value="${c.quantity}" min="1">
                                <button type="button" class="btn btn-sm btn-outline-secondary btn-plus" data-id="${c.id}">+</button>
                                <button type="submit" class="btn btn-sm btn-outline-primary">更新</button>
                            </form>
                        </td>
                        <td class="text-danger fw-bold">¥${c.subtotal}</td>
                        <td>
                            <a href="${ctx}/CartServlet?action=delete&id=${c.id}" class="btn btn-sm btn-outline-danger btn-confirm" data-confirm="确定从购物车移除该菜品吗？"><i class="bi bi-trash"></i></a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
                <tfoot>
                <tr>
                    <td colspan="3" class="text-end fw-bold">合计：</td>
                    <td class="text-danger fw-bold fs-5">¥${total}</td>
                    <td></td>
                </tr>
                </tfoot>
            </table>
            <div class="d-flex justify-content-between">
                <a href="${ctx}/DishServlet" class="btn btn-outline-secondary"><i class="bi bi-arrow-left"></i> 继续点餐</a>
                <a href="${ctx}/OrderServlet?action=confirm" class="btn btn-danger px-4">去结算 <i class="bi bi-chevron-right"></i></a>
            </div>
        </c:if>
    </div>
</div>

<script>
$(function () {
    // 数量加减
    $('.btn-minus').on('click', function () {
        var input = $(this).closest('form').find('input[name="quantity"]');
        var v = parseInt(input.val()) || 1;
        if (v > 1) input.val(v - 1);
    });
    $('.btn-plus').on('click', function () {
        var input = $(this).closest('form').find('input[name="quantity"]');
        var v = parseInt(input.val()) || 0;
        input.val(v + 1);
    });
});
</script>
<%@ include file="../common/footer.jsp" %>
