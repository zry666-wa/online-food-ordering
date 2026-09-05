package com.food.entity;

import java.util.Date;

/** 商家实体，对应 t_merchant 表 */
public class Merchant {
    private Integer id;
    private Integer userId;
    private String shopName;
    private String shopDesc;
    private String address;
    private String licenseNo;
    private Integer status; // 0待审核 1通过 2驳回
    private Date createTime;

    private String username;   // 关联用户名（联表查询）
    private String phone;      // 关联用户手机号

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }
    public String getShopName() { return shopName; }
    public void setShopName(String shopName) { this.shopName = shopName; }
    public String getShopDesc() { return shopDesc; }
    public void setShopDesc(String shopDesc) { this.shopDesc = shopDesc; }
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    public String getLicenseNo() { return licenseNo; }
    public void setLicenseNo(String licenseNo) { this.licenseNo = licenseNo; }
    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }
    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
}
