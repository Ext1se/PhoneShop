package com.tpu.shop.utils;

import com.tpu.shop.data.SmartPhone;

import java.io.Serializable;

public class ProductLine implements Serializable {

    private SmartPhone smartPhone;
    private int count;

    public ProductLine() {
    }

    public SmartPhone getSmartPhone() {
        return smartPhone;
    }

    public void setSmartPhone(SmartPhone smartPhone) {
        this.smartPhone = smartPhone;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }
}