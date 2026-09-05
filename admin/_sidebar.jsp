<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- 管理端侧边栏 -->
<div class="col-lg-3 mb-4">
    <div class="card sidebar border-0 shadow-sm">
        <div class="card-body text-center bg-dark text-white">
            <i class="bi bi-shield-lock" style="font-size:2.5rem;"></i>
            <h6 class="mt-2 mb-0 fw-bold">系统管理后台</h6>
            <small>管理员：${sessionScope.loginUser.username}</small>
        </div>
        <div class="list-group list-group-flush">
            <a href="${ctx}/AdminServlet?action=index" class="list-group-item list-group-item-action ${active == 'index' ? 'active' : ''}"><i class="bi bi-speedometer2"></i> 数据总览</a>
            <a href="${ctx}/AdminServlet?action=userList" class="list-group-item list-group-item-action ${active == 'userList' ? 'active' : ''}"><i class="bi bi-people"></i> 用户管理</a>
            <a href="${ctx}/AdminServlet?action=merchantList" class="list-group-item list-group-item-action ${active == 'merchantList' ? 'active' : ''}"><i class="bi bi-shop"></i> 商家管理</a>
            <a href="${ctx}/AdminServlet?action=orderList" class="list-group-item list-group-item-action ${active == 'orderList' ? 'active' : ''}"><i class="bi bi-receipt"></i> 订单管理</a>
            <a href="${ctx}/AdminServlet?action=dishList" class="list-group-item list-group-item-action ${active == 'dishList' ? 'active' : ''}"><i class="bi bi-egg-fried"></i> 菜品管理</a>
            <a href="${ctx}/AdminServlet?action=categoryList" class="list-group-item list-group-item-action ${active == 'categoryList' ? 'active' : ''}"><i class="bi bi-tags"></i> 分类管理</a>
            <a href="${ctx}/AdminServlet?action=reviewList" class="list-group-item list-group-item-action ${active == 'reviewList' ? 'active' : ''}"><i class="bi bi-star"></i> 评价管理</a>
            <a href="${ctx}/AdminServlet?action=announcementList" class="list-group-item list-group-item-action ${active == 'announcementList' ? 'active' : ''}"><i class="bi bi-megaphone"></i> 公告管理</a>
        </div>
    </div>
</div>
