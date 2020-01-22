package com.tpu.shop.data;

import com.fasterxml.jackson.annotation.JsonView;
import org.springframework.web.multipart.MultipartFile;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "model_color")
public class ModelColor {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_model_color")
    @JsonView({Views.Id.class, Views.FullModel.class, Views.FullSmartPhone.class})
    private Long id;

    @ManyToOne(targetEntity = Model.class)
    @JoinColumn(name = "id_model", nullable = false,
            foreignKey = @ForeignKey(
                    name = "fk_base_model_color",
                    foreignKeyDefinition = "FOREIGN KEY (id_model) REFERENCES model (id_model) " +
                            "ON DELETE CASCADE " +
                            "ON UPDATE CASCADE"
            ))
    @JsonView({Views.FullColorModel.class, Views.FullSmartPhone.class})
    private Model model;

    @ManyToOne(targetEntity = Color.class, fetch = FetchType.LAZY)
    @JoinColumn(name = "id_color",
            foreignKey = @ForeignKey(
                    name = "fk_model_color",
                    foreignKeyDefinition = "FOREIGN KEY (id_color) REFERENCES color (id_color) " +
                            "ON DELETE SET NULL " +
                            "ON UPDATE CASCADE"
            ))
    @JsonView({Views.FullColorModel.class, Views.FullModel.class, Views.FullSmartPhone.class})
    private Color color;

    @OneToMany(targetEntity = ModelPhoto.class, fetch = FetchType.LAZY)
    @JoinColumn(name = "id_model_color",
            foreignKey = @ForeignKey(
                    name = "fk_model_photo",
                    foreignKeyDefinition = "FOREIGN KEY (id_model_color) REFERENCES model_photo(id_model_color) " +
                    "ON DELETE CASCADE " +
                    "ON UPDATE CASCADE"
            ))
    @JsonView({Views.Base.class, Views.FullModel.class, Views.FullSmartPhone.class})
    private List<ModelPhoto> photos;

    @OneToMany(mappedBy = "colorModel", targetEntity = SmartPhone.class, fetch = FetchType.EAGER)
    @JsonView(Views.FullModel.class)
    private List<SmartPhone> configurations;

    public ModelColor() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Model getModel() {
        return model;
    }

    public void setModel(Model model) {
        this.model = model;
    }

    public Color getColor() {
        return color;
    }

    public void setColor(Color color) {
        this.color = color;
    }

    public List<ModelPhoto> getPhotos() {
        return photos;
    }

    public void setPhotos(List<ModelPhoto> photos) {
        this.photos = photos;
    }

    public List<SmartPhone> getConfigurations() {
        return configurations;
    }

    public void setConfigurations(List<SmartPhone> configurations) {
        this.configurations = configurations;
    }
}
