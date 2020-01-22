package com.tpu.shop.utils;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.tpu.shop.data.Address;
import com.tpu.shop.data.SmartPhone;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.List;

public class PreOrder implements Serializable {

    private Address address;
    private Integer typeDelivery;
    private String phoneNumber;
    private List<ProductLine> productLines;
    private Integer sum;
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "dd.MM.yyyy HH:mm")
    private LocalDateTime dateDelivery;

    public PreOrder() {

    }

    public Address getAddress() {
        return address;
    }

    public void setAddress(Address address) {
        this.address = address;
    }

    public Integer getTypeDelivery() {
        return typeDelivery;
    }

    public void setTypeDelivery(Integer typeDelivery) {
        this.typeDelivery = typeDelivery;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public List<ProductLine> getProductLines() {
        return productLines;
    }

    public void setProductLines(List<ProductLine> productLines) {
        this.productLines = productLines;
    }

    public Integer getSum() {
        return sum;
    }

    public void setSum(Integer sum) {
        this.sum = sum;
    }

    public LocalDateTime getDateDelivery() {
        return dateDelivery;
    }

    public void setDateDelivery(LocalDateTime dateDelivery) {
        this.dateDelivery = dateDelivery;
    }

}
