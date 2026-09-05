<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../common/header.jsp" %>
<%@ include file="_sidebar.jsp" %>

<div class="col-lg-9">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h5 class="fw-bold mb-0"><i class="bi bi-tags text-danger"></i> 分类管理</h5>
    </div>
    <div class="card border-0 shadow-sm mb-3">
        <div class="card-body">
            <form class="row g-2" action="${ctx}/AdminServlet" method="get">
                <input type="hidden" name="action" value="categoryAdd">
                <div class="col-auto"><input type="text" class="form-control" name="name" placeholder="分类名称" required></div>
                <div class="col-auto"><input type="number" class="form-control" name="sort" placeholder="排序号" value="0"></div>
                <div class="col-auto"><button class="btn btn-danger">新增分类</button></div>
            </form>
        </div>
    </div>
    <div class="card border-0 shadow-sm">
        <div class="card-body p-0">
            <table class="table table-hover align-middle mb-0">
                <thead><tr><th>ID</th><th>分类名称</th><th>排序</th><th>创建时间</th><th>操作</th></tr></thead>
                <tbody>
                <c:forEach items="${categories}" var="c">
                    <tr>
                        <td>${c.id}</td>
                        <td>${c.name}</td>
                        <td>${c.sort}</td>
                        <td><fmt:formatDate value="${c.createTime}" pattern="yyyy-MM-dd"/></td>
                        <td>
                            <a href="${ctx}/AdminServlet?action=categoryDelete&id=${c.id}" class="btn btn-sm btn-outline-danger btn-confirm" data-confirm="确定删除该分类？">删除</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>
