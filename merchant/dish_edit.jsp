<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/header.jsp" %>
<%@ include file="_sidebar.jsp" %>

<div class="col-lg-9">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h5 class="fw-bold mb-0"><i class="bi bi-egg-fried text-danger"></i> ${empty dish ? '新增菜品' : '编辑菜品'}</h5>
        <a href="${ctx}/MerchantServlet?action=dishList" class="btn btn-outline-secondary btn-sm">返回</a>
    </div>
    <div class="card border-0 shadow-sm">
        <div class="card-body">
            <form action="${ctx}/MerchantServlet" method="get">
                <input type="hidden" name="action" value="dishSave">
                <c:if test="${not empty dish}">
                    <input type="hidden" name="id" value="${dish.id}">
                </c:if>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">菜品名称 <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" name="name" value="${dish.name}" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">分类 <span class="text-danger">*</span></label>
                        <select class="form-select" name="categoryId" required>
                            <option value="">请选择分类</option>
                            <c:forEach items="${categories}" var="cat">
                                <option value="${cat.id}" ${dish.categoryId == cat.id ? 'selected' : ''}>${cat.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">价格 <span class="text-danger">*</span></label>
                        <input type="number" step="0.01" min="0" class="form-control" name="price" value="${dish.price}" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">图片路径</label>
                        <input type="text" class="form-control" name="image" value="${dish.image}" placeholder="images/dish/xxx.jpg">
                    </div>
                </div>
                <div class="mb-3">
                    <label class="form-label">菜品描述</label>
                    <textarea class="form-control" name="description" rows="3">${dish.description}</textarea>
                </div>
                <button type="submit" class="btn btn-danger">保存</button>
            </form>
        </div>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>
