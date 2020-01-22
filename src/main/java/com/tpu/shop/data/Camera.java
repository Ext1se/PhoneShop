package com.tpu.shop.data;

import com.fasterxml.jackson.annotation.JsonView;
import com.google.gson.annotations.SerializedName;
import com.tpu.shop.utils.ValidationMessage;
import org.hibernate.validator.constraints.Length;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import java.io.Serializable;

//Для РЕСТ запроса использовать fetch = FetchType.EAGER
@Entity
@Table(name = "camera")
public class Camera implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_camera", nullable = false, unique = true)
    @JsonView({Views.FullModel.class, Views.FullSmartPhone.class})
    private Long id;

    @NotBlank(message = ValidationMessage.EMPTY_FIELD)
    @Length(max = 200)
    @Column(nullable = false)
    @JsonView({Views.FullModel.class, Views.FullSmartPhone.class})
    private String name;

    @ManyToOne(targetEntity = Resolution.class, fetch = FetchType.EAGER)
    @JoinColumn(name = "id_resolution_photo", nullable = true,
            foreignKey = @ForeignKey(
                    name = "fk_camera_photo",
                    foreignKeyDefinition = "FOREIGN KEY (id_resolution_photo) REFERENCES resolution(id_resolution) " +
                            "ON UPDATE CASCADE " +
                            "ON DELETE SET NULL"
            ))
    @JsonView({Views.FullModel.class, Views.FullSmartPhone.class})
    private Resolution resolutionPhoto;

    @ManyToOne(targetEntity = Resolution.class, fetch = FetchType.EAGER)
    @JoinColumn(name = "id_resolution_video", nullable = true,
            foreignKey = @ForeignKey(
                    name = "fk_camera_video",
                    foreignKeyDefinition = "FOREIGN KEY (id_resolution_video) REFERENCES resolution(id_resolution) " +
                            "ON UPDATE CASCADE " +
                            "ON DELETE SET NULL"
            ))
    @JsonView({Views.FullModel.class, Views.FullSmartPhone.class})
    private Resolution resolutionVideo;

    public Camera() {
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

    public Resolution getResolutionPhoto() {
        return resolutionPhoto;
    }

    public void setResolutionPhoto(Resolution resolutionPhoto) {
        this.resolutionPhoto = resolutionPhoto;
    }

    public Resolution getResolutionVideo() {
        return resolutionVideo;
    }

    public void setResolutionVideo(Resolution resolutionVideo) {
        this.resolutionVideo = resolutionVideo;
    }
}
