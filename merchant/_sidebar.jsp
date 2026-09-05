<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- 商家端侧边栏 -->
<div class="col-lg-3 mb-4">
    <div class="card sidebar border-0 shadow-sm">
        <div class="card-body text-center bg-danger text-white">
            <i class="bi bi-shop-window" style="font-size:2.5rem;"></i>
            <h6 class="mt-2 mb-0 fw-bold">${merchant.shopName}</h6>
            <small>商家工作台</small>
        </div>
        <div class="list-group list-group-flush">
            <a href="${ctx}/MerchantServlet?action=dashboard" class="list-group-item list-group-item-action ${active == 'dashboard' ? 'active' : ''}"><i class="bi bi-speedometer2"></i> 经营看板</a>
            <a href="${ctx}/MerchantServlet?action=dishList" class="list-group-item list-group-item-action ${active == 'dishList' ? 'active' : ''}"><i class="bi bi-egg-fried"></i> 菜品管理</a>
            <a href="${ctx}/MerchantServlet?action=orderList" class="list-group-item list-group-item-action ${active == 'orderList' ? 'active' : ''}"><i class="bi bi-receipt"></i> 订单管理</a>
            <a href="${ctx}/MerchantServlet?action=reviews" class="list-group-item list-group-item-action ${active == 'reviews' ? 'active' : ''}"><i class="bi bi-star"></i> 顾客评价</a>
            <a href="${ctx}/MerchantServlet?action=profile" class="list-group-item list-group-item-action ${active == 'profile' ? 'active' : ''}"><i class="bi bi-shop"></i> 店铺资料</a>
        </div>
    </div>
</div>
