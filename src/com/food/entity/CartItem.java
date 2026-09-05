package com.food.entity;

import java.util.Date;

/** 购物车条目实体，对应 t_cart 表 */
public class CartItem {
    private Integer id;
    private Integer userId;
    private Integer dishId;
    private Integer quantity;
    private Date addTime;

    // 联表字段
    private String dishName;
    private java.math.BigDecimal price;
    private String image;
    private Integer merchantId;
    private String shopName;
    private java.math.BigDecimal subtotal;

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }
    public Integer getDishId() { return dishId; }
    public void setDishId(Integer dishId) { this.dishId = dishId; }
    public Integer getQuantity() { return quantity; }
    public void setQuantity(Integer quantity) { this.quantity = quantity; }
    public Date getAddTime() { return addTime; }
    public void setAddTime(Date addTime) { this.addTime = addTime; }
    public String getDishName() { return dishName; }
    public void setDishName(String dishName) { this.dishName = dishName; }
    public java.math.BigDecimal getPrice() { return price; }
    public void setPrice(java.math.BigDecimal price) { this.price = price; }
    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }
    public Integer getMerchantId() { return merchantId; }
    public void setMerchantId(Integer merchantId) { this.merchantId = merchantId; }
    public String getShopName() { return shopName; }
    public void setShopName(String shopName) { this.shopName = shopName; }
    public java.math.BigDecimal getSubtotal() { return subtotal; }
    public void setSubtotal(java.math.BigDecimal subtotal) { this.subtotal = subtotal; }
}
