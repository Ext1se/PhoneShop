package com.tpu.shop.data;

import com.fasterxml.jackson.annotation.JsonView;
import com.tpu.shop.utils.ValidationMessage;
import org.hibernate.validator.constraints.Length;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import java.util.Set;

@Entity
@Table(name = "cpu")
public class Cpu {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_cpu")
    @JsonView({Views.FullModel.class, Views.FullSmartPhone.class})
    private Long id;

    @NotBlank(message = ValidationMessage.EMPTY_FIELD)
    @Length(max = 200)
    @Column(nullable = false)
    @JsonView({Views.FullModel.class, Views.FullSmartPhone.class})
    private String name;

    @JsonView({Views.FullModel.class, Views.FullSmartPhone.class})
    private Integer beans;
    @JsonView({Views.FullModel.class, Views.FullSmartPhone.class})
    private Integer frequency;
    @JsonView({Views.FullModel.class, Views.FullSmartPhone.class})
    private Integer size;
    @JsonView({Views.FullModel.class, Views.FullSmartPhone.class})
    private Integer bit;

    // При использовании с REST будет бесконечный цикл JSON
    //@OneToMany(mappedBy = "cpu", cascade = CascadeType.ALL)
    //private Set<Model> models;

    public Cpu() {

    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getBeans() {
        return beans;
    }

    public void setBeans(int beans) {
        this.beans = beans;
    }

    public Integer getFrequency() {
        return frequency;
    }

    public void setFrequency(int frequency) {
        this.frequency = frequency;
    }

    public Integer getSize() {
        return size;
    }

    public void setSize(int size) {
        this.size = size;
    }

    public Integer getBit() {
        return bit;
    }

    public void setBit(int bit) {
        this.bit = bit;
    }

    @PreUpdate
    private void preUpdate() {
    }

    @PostUpdate
    private void postUpdate() {
    }
}
