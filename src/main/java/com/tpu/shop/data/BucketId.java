package com.tpu.shop.data;

import javax.persistence.Embeddable;
import javax.persistence.JoinColumn;
import java.io.Serializable;

@Embeddable
public class BucketId implements Serializable {
    @JoinColumn(name = "id_order")
    private Long idOrder;

    @JoinColumn(name = "id_product")
    private Long idSmartPhone;

    public BucketId() {
    }

    public Long getIdOrder() {
        return idOrder;
    }

    public void setIdOrder(Long idOrder) {
        this.idOrder = idOrder;
    }

    public Long getIdSmartPhone() {
        return idSmartPhone;
    }

    public void setIdSmartPhone(Long idSmartPhone) {
        this.idSmartPhone = idSmartPhone;
    }
}
