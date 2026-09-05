// 网上订餐系统 公共脚本
$(function () {
    // 通用确认弹窗
    $('.btn-confirm').on('click', function (e) {
        var msg = $(this).data('confirm') || '确定执行该操作吗？';
        if (!window.confirm(msg)) {
            e.preventDefault();
        }
    });

    // 自动隐藏可关闭的提示
    setTimeout(function () {
        $('.alert-dismissible').fadeOut('slow');
    }, 4000);
});
