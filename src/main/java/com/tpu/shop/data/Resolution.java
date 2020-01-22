package com.tpu.shop.data;

import com.fasterxml.jackson.annotation.JsonView;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import java.io.Serializable;

@Entity
@Table(name = "resolution")
public class Resolution implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_resolution")
    @JsonView({Views.FullModel.class, Views.FullSmartPhone.class})
    private Long id;

    @JsonView({Views.FullModel.class, Views.FullSmartPhone.class})
    private Integer resolution;
    @Column(nullable = false)
    @JsonView({Views.FullModel.class, Views.FullSmartPhone.class})
    private Integer resolutionX;
    @Column(nullable = false)
    @JsonView({Views.FullModel.class, Views.FullSmartPhone.class})
    private Integer resolutionY;

    public Resolution() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Integer getResolution() {
        return resolution;
    }

    public void setResolution(int resolution) {
        this.resolution = resolution;
    }

    public Integer getResolutionX() {
        return resolutionX;
    }

    public void setResolutionX(int resolutionX) {
        this.resolutionX = resolutionX;
    }

    public Integer getResolutionY() {
        return resolutionY;
    }

    public void setResolutionY(int resolutionY) {
        this.resolutionY = resolutionY;
    }
}
