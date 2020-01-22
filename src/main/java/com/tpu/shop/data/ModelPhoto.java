package com.tpu.shop.data;

import com.fasterxml.jackson.annotation.JsonView;

import javax.persistence.*;

@Entity
@Table(name = "model_photo")
public class ModelPhoto {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_model_photo")
    @JsonView({Views.Base.class, Views.FullModel.class, Views.FullSmartPhone.class})
    private Long id;

    /*
    @ManyToOne(targetEntity = ModelColor.class, fetch = FetchType.LAZY)
    @JoinColumn(name = "id_model_color",
            foreignKey = @ForeignKey(
                    name = "fk_model_photo",
                    foreignKeyDefinition = "FOREIGN KEY (id_model_color) REFERENCES model_color(id_model_color) " +
                            "ON DELETE CASCADE " +
                            "ON UPDATE CASCADE"
            ))
    private ModelColor modelColor;
    */

    @Column(nullable = true)
    @JsonView({Views.Base.class, Views.FullModel.class, Views.FullSmartPhone.class})
    private Integer position;

    @Column(nullable = false)
    @JsonView({Views.Base.class, Views.FullModel.class, Views.FullSmartPhone.class})
    private String url;

    public ModelPhoto() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Integer getPosition() {
        return position;
    }

    public void setPosition(int position) {
        this.position = position;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }
}
