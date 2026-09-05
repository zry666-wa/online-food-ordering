<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../common/header.jsp" %>
<%@ include file="_sidebar.jsp" %>

<div class="col-lg-9">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h5 class="fw-bold mb-0"><i class="bi bi-people text-danger"></i> 用户管理</h5>
        <form class="d-flex gap-2" action="${ctx}/AdminServlet" method="get">
            <input type="hidden" name="action" value="userList">
            <select class="form-select form-select-sm" name="role" style="width:130px;">
                <option value="">全部角色</option>
                <option value="customer" ${role == 'customer' ? 'selected' : ''}>顾客</option>
                <option value="merchant" ${role == 'merchant' ? 'selected' : ''}>商家</option>
                <option value="admin" ${role == 'admin' ? 'selected' : ''}>管理员</option>
            </select>
            <input type="text" class="form-control form-control-sm" name="keyword" value="${keyword}" placeholder="用户名/姓名/手机">
            <button class="btn btn-sm btn-danger">查询</button>
        </form>
    </div>
    <div class="card border-0 shadow-sm">
        <div class="card-body p-0">
            <table class="table table-hover align-middle mb-0">
                <thead><tr><th>ID</th><th>用户名</th><th>姓名</th><th>手机</th><th>角色</th><th>状态</th><th>注册时间</th><th>操作</th></tr></thead>
                <tbody>
                <c:forEach items="${users}" var="u">
                    <tr>
                        <td>${u.id}</td>
                        <td>${u.username}</td>
                        <td>${u.realName}</td>
                        <td>${u.phone}</td>
                        <td>
                            <c:choose>
                                <c:when test="${u.role == 'admin'}"><span class="badge bg-dark">管理员</span></c:when>
                                <c:when test="${u.role == 'merchant'}"><span class="badge bg-primary">商家</span></c:when>
                                <c:otherwise><span class="badge bg-info text-dark">顾客</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td><span class="badge ${u.status == 1 ? 'bg-success' : 'bg-secondary'}">${u.status == 1 ? '正常' : '禁用'}</span></td>
                        <td><fmt:formatDate value="${u.createTime}" pattern="yyyy-MM-dd"/></td>
                        <td>
                            <c:if test="${u.role != 'admin'}">
                                <a href="${ctx}/AdminServlet?action=userToggle&id=${u.id}&status=${u.status == 1 ? 0 : 1}"
                                   class="btn btn-sm btn-outline-${u.status == 1 ? 'danger' : 'success'} btn-confirm"
                                   data-confirm="确定${u.status == 1 ? '禁用' : '启用'}该用户？">${u.status == 1 ? '禁用' : '启用'}</a>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>
