package com.tpu.shop.data;

import com.fasterxml.jackson.annotation.JsonView;
import com.tpu.shop.utils.StringUtils;

import javax.persistence.*;

@Entity
@Table(name = "address")
public class Address {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_address")
    @JsonView({Views.User.class, Views.Order.class})
    private Long id;

    @JsonView({Views.User.class, Views.Order.class})
    private String city;
    @JsonView({Views.User.class, Views.Order.class})
    private String street;
    @JsonView({Views.User.class, Views.Order.class})
    private String house;
    @JsonView({Views.User.class, Views.Order.class})
    private String apartment;

    public Address() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getStreet() {
        return street;
    }

    public void setStreet(String street) {
        this.street = street;
    }

    public String getHouse() {
        return house;
    }

    public void setHouse(String house) {
        this.house = house;
    }

    public String getApartment() {
        return apartment;
    }

    public void setApartment(String apartment) {
        this.apartment = apartment;
    }

    public boolean isCompleted() {
        return (StringUtils.checkString(getCity()) && StringUtils.checkString(getStreet()) && StringUtils.checkString(getHouse()) && StringUtils.checkString(getApartment()));
    }

    public boolean isEmpty() {
        return (!StringUtils.checkString(getCity()) && !StringUtils.checkString(getStreet()) && !StringUtils.checkString(getHouse()) && !StringUtils.checkString(getApartment()));
    }
}
