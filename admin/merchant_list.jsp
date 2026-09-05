<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../common/header.jsp" %>
<%@ include file="_sidebar.jsp" %>

<div class="col-lg-9">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h5 class="fw-bold mb-0"><i class="bi bi-shop text-danger"></i> 商家管理 / 入驻审核</h5>
    </div>
    <div class="btn-group mb-3" role="group">
        <a href="${ctx}/AdminServlet?action=merchantList" class="btn ${empty currentStatus ? 'btn-dark' : 'btn-outline-dark'} btn-sm">全部</a>
        <a href="${ctx}/AdminServlet?action=merchantList&status=0" class="btn ${currentStatus == 0 ? 'btn-dark' : 'btn-outline-dark'} btn-sm">待审核</a>
        <a href="${ctx}/AdminServlet?action=merchantList&status=1" class="btn ${currentStatus == 1 ? 'btn-dark' : 'btn-outline-dark'} btn-sm">已通过</a>
        <a href="${ctx}/AdminServlet?action=merchantList&status=2" class="btn ${currentStatus == 2 ? 'btn-dark' : 'btn-outline-dark'} btn-sm">已驳回</a>
    </div>
    <div class="card border-0 shadow-sm">
        <div class="card-body p-0">
            <table class="table table-hover align-middle mb-0">
                <thead><tr><th>ID</th><th>店铺名称</th><th>店主</th><th>地址</th><th>状态</th><th>申请时间</th><th>审核操作</th></tr></thead>
                <tbody>
                <c:forEach items="${merchants}" var="m">
                    <tr>
                        <td>${m.id}</td>
                        <td>${m.shopName}</td>
                        <td>${m.username} <span class="text-muted small">(${m.phone})</span></td>
                        <td>${m.address}</td>
                        <td>
                            <span class="badge
                                <c:choose>
                                    <c:when test="${m.status == 0}">bg-warning text-dark</c:when>
                                    <c:when test="${m.status == 1}">bg-success</c:when>
                                    <c:otherwise>bg-secondary</c:otherwise>
                                </c:choose>">
                                <c:choose>
                                    <c:when test="${m.status == 0}">待审核</c:when>
                                    <c:when test="${m.status == 1}">已通过</c:when>
                                    <c:otherwise>已驳回</c:otherwise>
                                </c:choose>
                            </span>
                        </td>
                        <td><fmt:formatDate value="${m.createTime}" pattern="yyyy-MM-dd"/></td>
                        <td>
                            <c:if test="${m.status == 0}">
                                <a href="${ctx}/AdminServlet?action=merchantAudit&id=${m.id}&status=1" class="btn btn-sm btn-success btn-confirm" data-confirm="审核通过该商家入驻申请？">通过</a>
                                <a href="${ctx}/AdminServlet?action=merchantAudit&id=${m.id}&status=2" class="btn btn-sm btn-outline-secondary btn-confirm" data-confirm="驳回该商家入驻申请？">驳回</a>
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
