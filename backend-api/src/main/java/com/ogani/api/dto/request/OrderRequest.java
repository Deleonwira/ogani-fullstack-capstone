package com.ogani.api.dto.request;


import lombok.Data;

@Data
public class OrderRequest {
    private Integer addressId; // Can be null if using inline shipping info
    private Integer paymentMethodId;
    
    private String receiverName;
    private String receiverPhone;
    private String shippingAddress;
    
    // Optional promo code
    private String promoCode;
}
