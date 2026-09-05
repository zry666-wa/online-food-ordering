<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../common/header.jsp" %>
<%@ include file="_sidebar.jsp" %>

<div class="col-lg-9">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h5 class="fw-bold mb-0"><i class="bi bi-star text-danger"></i> 顾客评价</h5>
    </div>
    <c:if test="${empty reviews}">
        <div class="text-center text-muted py-5">暂无评价</div>
    </c:if>
    <c:forEach items="${reviews}" var="r">
        <div class="card border-0 shadow-sm mb-3">
            <div class="card-body">
                <div class="d-flex justify-content-between">
                    <strong>${r.username} <span class="text-muted small fw-normal">对「${r.dishName}」的评价</span></strong>
                    <span class="text-warning">
                        <c:forEach begin="1" end="${r.rating}"><i class="bi bi-star-fill"></i></c:forEach>
                    </span>
                </div>
                <p class="mb-1 mt-2">${r.content}</p>
                <div class="small text-muted"><fmt:formatDate value="${r.createTime}" pattern="yyyy-MM-dd HH:mm"/></div>
            </div>
        </div>
    </c:forEach>
</div>

<%@ include file="../common/footer.jsp" %>
