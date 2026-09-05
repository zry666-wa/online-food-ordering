<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/header.jsp" %>
<%@ include file="_sidebar.jsp" %>

<div class="col-lg-9">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h5 class="fw-bold mb-0"><i class="bi bi-egg-fried text-danger"></i> 菜品管理</h5>
    </div>
    <div class="card border-0 shadow-sm">
        <div class="card-body p-0">
            <table class="table table-hover align-middle mb-0">
                <thead><tr><th>ID</th><th>菜品</th><th>商家</th><th>分类</th><th>价格</th><th>销量</th><th>状态</th><th>操作</th></tr></thead>
                <tbody>
                <c:forEach items="${dishes}" var="d">
                    <tr>
                        <td>${d.id}</td>
                        <td>${d.name}</td>
                        <td>${d.shopName}</td>
                        <td>${d.categoryName}</td>
                        <td class="text-danger fw-bold">¥${d.price}</td>
                        <td>${d.sales}</td>
                        <td><span class="badge ${d.status == 1 ? 'bg-success' : 'bg-secondary'}">${d.status == 1 ? '在售' : '下架'}</span></td>
                        <td>
                            <a href="${ctx}/AdminServlet?action=dishToggle&id=${d.id}&status=${d.status == 1 ? 0 : 1}"
                               class="btn btn-sm btn-outline-${d.status == 1 ? 'danger' : 'success'} btn-confirm"
                               data-confirm="确定${d.status == 1 ? '下架' : '上架'}该菜品？">${d.status == 1 ? '下架' : '上架'}</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>
