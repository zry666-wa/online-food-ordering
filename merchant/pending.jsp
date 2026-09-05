<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/header.jsp" %>

<div class="text-center py-5">
    <c:choose>
        <c:when test="${merchant.status == 0}">
            <i class="bi bi-hourglass-split text-warning" style="font-size:4rem;"></i>
            <h4 class="mt-3 fw-bold">入驻申请审核中</h4>
            <p class="text-muted">您的店铺「${merchant.shopName}」入驻申请已提交，等待系统管理员审核。审核通过后即可上架菜品、处理订单。</p>
        </c:when>
        <c:when test="${merchant.status == 2}">
            <i class="bi bi-x-circle text-danger" style="font-size:4rem;"></i>
            <h4 class="mt-3 fw-bold">入驻申请被驳回</h4>
            <p class="text-muted">您的入驻申请未通过审核，请检查店铺资料或联系管理员。</p>
        </c:when>
    </c:choose>
    <div class="mt-4">
        <a href="${ctx}/DishServlet" class="btn btn-danger">返回首页</a>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>
