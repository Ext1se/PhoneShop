package com.tpu.shop.data;


import com.fasterxml.jackson.annotation.JsonView;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "order_product")
public class Bucket implements Serializable {

    @EmbeddedId
    private BucketId id;

    //@Id
    @ManyToOne(fetch = FetchType.EAGER)
    @MapsId("idOrder")
    @JoinColumn(name = "id_order",
            foreignKey = @ForeignKey(
                    name = "fk_bucket_order",
                    foreignKeyDefinition = "FOREIGN KEY (id_order) REFERENCES `order`(id_order) " +
                            "ON DELETE CASCADE " +
                            "ON UPDATE CASCADE"
            ))
    private Order order;

    //@Id
    @ManyToOne(fetch = FetchType.EAGER)
    @MapsId("idSmartPhone")
    @JoinColumn(name = "id_product",
            foreignKey = @ForeignKey(
                    name = "fk_bucket_product",
                    foreignKeyDefinition = "FOREIGN KEY (id_product) REFERENCES product(id_product) " +
                            "ON DELETE CASCADE " +
                            "ON UPDATE CASCADE"
            ))
    @JsonView({Views.Order.class})
    private SmartPhone smartPhone;

    @JsonView({Views.Order.class})
    private Integer count;

    public Bucket() {
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public SmartPhone getSmartPhone() {
        return smartPhone;
    }

    public void setSmartPhone(SmartPhone smartPhone) {
        this.smartPhone = smartPhone;
    }

    public BucketId getId() {
        return id;
    }

    public void setId(BucketId id) {
        this.id = id;
    }
}
