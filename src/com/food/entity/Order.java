package com.food.entity;

import java.util.Date;
import java.util.List;

/** 订单实体，对应 t_order 表 */
public class Order {
    private Integer id;
    private String orderNo;
    private Integer userId;
    private Integer merchantId;
    private java.math.BigDecimal totalAmount;
    private Integer status;   // 0待支付 1待接单 2制作中 3配送中 4已完成 5已取消
    private String address;
    private String phone;
    private String remark;
    private Date createTime;
    private Date payTime;
    private Date finishTime;

    // 联表字段
    private String username;
    private String shopName;
    private List<OrderItem> items;

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public String getOrderNo() { return orderNo; }
    public void setOrderNo(String orderNo) { this.orderNo = orderNo; }
    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }
    public Integer getMerchantId() { return merchantId; }
    public void setMerchantId(Integer merchantId) { this.merchantId = merchantId; }
    public java.math.BigDecimal getTotalAmount() { return totalAmount; }
    public void setTotalAmount(java.math.BigDecimal totalAmount) { this.totalAmount = totalAmount; }
    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public String getRemark() { return remark; }
    public void setRemark(String remark) { this.remark = remark; }
    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }
    public Date getPayTime() { return payTime; }
    public void setPayTime(Date payTime) { this.payTime = payTime; }
    public Date getFinishTime() { return finishTime; }
    public void setFinishTime(Date finishTime) { this.finishTime = finishTime; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getShopName() { return shopName; }
    public void setShopName(String shopName) { this.shopName = shopName; }
    public List<OrderItem> getItems() { return items; }
    public void setItems(List<OrderItem> items) { this.items = items; }

    /** 订单状态中文名称 */
    public String getStatusText() {
        switch (status == null ? -1 : status) {
            case 0: return "待支付";
            case 1: return "待接单";
            case 2: return "制作中";
            case 3: return "配送中";
            case 4: return "已完成";
            case 5: return "已取消";
            default: return "未知";
        }
    }
}
