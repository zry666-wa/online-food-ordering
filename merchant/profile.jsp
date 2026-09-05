<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/header.jsp" %>
<%@ include file="_sidebar.jsp" %>

<div class="col-lg-9">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h5 class="fw-bold mb-0"><i class="bi bi-shop text-danger"></i> 店铺资料</h5>
    </div>
    <c:if test="${not empty msg}"><div class="alert alert-success py-2">${msg}</div></c:if>
    <div class="card border-0 shadow-sm">
        <div class="card-body">
            <form action="${ctx}/MerchantServlet" method="get">
                <input type="hidden" name="action" value="profileSave">
                <div class="mb-3">
                    <label class="form-label">店铺名称 <span class="text-danger">*</span></label>
                    <input type="text" class="form-control" name="shopName" value="${merchant.shopName}" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">店铺简介</label>
                    <textarea class="form-control" name="shopDesc" rows="3">${merchant.shopDesc}</textarea>
                </div>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">店铺地址</label>
                        <input type="text" class="form-control" name="address" value="${merchant.address}">
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">营业执照号</label>
                        <input type="text" class="form-control" name="licenseNo" value="${merchant.licenseNo}">
                    </div>
                </div>
                <button type="submit" class="btn btn-danger">保存店铺资料</button>
            </form>
        </div>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>
