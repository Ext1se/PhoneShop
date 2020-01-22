package com.tpu.shop.data;

import com.fasterxml.jackson.annotation.JsonView;
import com.tpu.shop.utils.ValidationMessage;
import org.hibernate.validator.constraints.Length;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;

@Entity
@Table(name = "gpu")
public class Gpu {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_gpu")
    @JsonView({Views.FullModel.class, Views.FullSmartPhone.class})
    private Long id;

    @NotBlank(message = ValidationMessage.EMPTY_FIELD)
    @Length(max = 200)
    @Column(nullable = false)
    @JsonView({Views.FullModel.class, Views.FullSmartPhone.class})
    private String name;

    @JsonView({Views.FullModel.class, Views.FullSmartPhone.class})
    private Integer frequency;

    public Gpu() {

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

    public Integer getFrequency() {
        return frequency;
    }

    public void setFrequency(int frequency) {
        this.frequency = frequency;
    }
}
