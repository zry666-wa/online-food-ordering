<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../common/header.jsp" %>
<%@ include file="_sidebar.jsp" %>

<div class="col-lg-9">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h5 class="fw-bold mb-0"><i class="bi bi-megaphone text-danger"></i> 公告管理</h5>
    </div>
    <div class="card border-0 shadow-sm mb-3">
        <div class="card-body">
            <form action="${ctx}/AdminServlet" method="get">
                <input type="hidden" name="action" value="announcementAdd">
                <div class="mb-2">
                    <input type="text" class="form-control" name="title" placeholder="公告标题" required>
                </div>
                <div class="mb-2">
                    <textarea class="form-control" name="content" rows="2" placeholder="公告内容" required></textarea>
                </div>
                <button class="btn btn-danger">发布公告</button>
            </form>
        </div>
    </div>
    <div class="card border-0 shadow-sm">
        <div class="card-body p-0">
            <table class="table table-hover align-middle mb-0">
                <thead><tr><th>ID</th><th>标题</th><th>内容</th><th>发布时间</th><th>操作</th></tr></thead>
                <tbody>
                <c:forEach items="${announcements}" var="a">
                    <tr>
                        <td>${a.id}</td>
                        <td>${a.title}</td>
                        <td class="text-truncate" style="max-width:320px;">${a.content}</td>
                        <td><fmt:formatDate value="${a.createTime}" pattern="yyyy-MM-dd"/></td>
                        <td>
                            <a href="${ctx}/AdminServlet?action=announcementDelete&id=${a.id}" class="btn btn-sm btn-outline-danger btn-confirm" data-confirm="确定删除该公告？">删除</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>
