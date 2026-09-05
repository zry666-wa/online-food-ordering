<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../common/header.jsp" %>
<%@ include file="_sidebar.jsp" %>

<div class="col-lg-9">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h5 class="fw-bold mb-0"><i class="bi bi-star text-danger"></i> 评价管理</h5>
    </div>
    <div class="card border-0 shadow-sm">
        <div class="card-body p-0">
            <table class="table table-hover align-middle mb-0">
                <thead><tr><th>ID</th><th>用户</th><th>菜品</th><th>评分</th><th>内容</th><th>时间</th></tr></thead>
                <tbody>
                <c:forEach items="${reviews}" var="r">
                    <tr>
                        <td>${r.id}</td>
                        <td>${r.username}</td>
                        <td>${r.dishName}</td>
                        <td class="text-warning">
                            <c:forEach begin="1" end="${r.rating}"><i class="bi bi-star-fill"></i></c:forEach>
                        </td>
                        <td>${r.content}</td>
                        <td><fmt:formatDate value="${r.createTime}" pattern="yyyy-MM-dd"/></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>
