package com.tpu.shop.data;


import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonView;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "`order`")
public class Order {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_order")
    @JsonView({Views.Order.class})
    private Long id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_address",
            foreignKey = @ForeignKey(
                    name = "fk_order_address",
                    foreignKeyDefinition = "FOREIGN KEY (id_address) REFERENCES address(id_address) " +
                            "ON DELETE SET NULL " +
                            "ON UPDATE CASCADE"
            ))
    @JsonView({Views.Order.class})
    private Address address;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_user",
            foreignKey = @ForeignKey(
                    name = "fk_order_user",
                    foreignKeyDefinition = "FOREIGN KEY (id_user) REFERENCES user(id_user) " +
                            "ON DELETE SET NULL " +
                            "ON UPDATE CASCADE"
            ))
    @JsonView({Views.Order.class})
    private User user;

    @Column(name = "id_order_state")
    @Enumerated(EnumType.ORDINAL)
    @JsonView({Views.Order.class})
    private OrderState state;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_delivery", nullable = false,
            foreignKey = @ForeignKey(
                    name = "fk_order_delivery",
                    foreignKeyDefinition = "FOREIGN KEY (id_delivery) REFERENCES delivery(id_delivery) " +
                            "ON DELETE SET NULL " +
                            "ON UPDATE CASCADE"
            ))
    @JsonView({Views.Order.class})
    private Delivery delivery;

    @OneToMany(mappedBy = "order")
    @JsonView({Views.Order.class})
    private List<Bucket> products;

    @Column(name = "phone_number", nullable = false)
    @JsonView({Views.Order.class})
    private String phoneNumber;

    @Column(name = "date_order")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "dd.MM.yyyy HH:mm:ss")
    @JsonView({Views.Order.class})
    private LocalDateTime dateOrder;

    @Column(name = "date_delivery")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "dd.MM.yyyy HH:mm")
    @JsonView({Views.Order.class})
    private LocalDateTime dateDelivery;

    @Column(name = "date_completed")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "dd.MM.yyyy HH:mm")
    @JsonView({Views.Order.class})
    private LocalDateTime dateCompleted;

    @JsonView({Views.Order.class})
    private Integer fullSum;

    public Order() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Address getAddress() {
        return address;
    }

    public void setAddress(Address address) {
        this.address = address;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public OrderState getState() {
        return state;
    }

    public void setState(OrderState state) {
        this.state = state;
    }

    public Delivery getDelivery() {
        return delivery;
    }

    public void setDelivery(Delivery delivery) {
        this.delivery = delivery;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public List<Bucket> getProducts() {
        return products;
    }

    public void setProducts(List<Bucket> products) {
        this.products = products;
    }

    public LocalDateTime getDateOrder() {
        return dateOrder;
    }

    public void setDateOrder(LocalDateTime dateOrder) {
        this.dateOrder = dateOrder;
    }

    public LocalDateTime getDateDelivery() {
        return dateDelivery;
    }

    public void setDateDelivery(LocalDateTime dateDelivery) {
        this.dateDelivery = dateDelivery;
    }

    public LocalDateTime getDateCompleted() {
        return dateCompleted;
    }

    public void setDateCompleted(LocalDateTime dateCompleted) {
        this.dateCompleted = dateCompleted;
    }

    public Integer getFullSum() {
        return fullSum;
    }

    public void setFullSum(Integer fullSum) {
        this.fullSum = fullSum;
    }


}
