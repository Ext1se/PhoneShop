package com.tpu.shop.data;

import com.fasterxml.jackson.annotation.JsonView;
import com.tpu.shop.utils.ValidationMessage;
import org.hibernate.validator.constraints.Length;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;

@Entity
@Table(name = "display")
public class Display {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_display")
    @JsonView({Views.FullModel.class, Views.FullSmartPhone.class})
    private Long id;

    @NotBlank(message = ValidationMessage.EMPTY_FIELD)
    @Length(max = 200)
    @Column(nullable = false)
    @JsonView({Views.FullModel.class, Views.FullSmartPhone.class})
    private String name;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_display_type",
            foreignKey = @ForeignKey(
                    name = "fk_display_type",
                    foreignKeyDefinition = "FOREIGN KEY (id_display_type) REFERENCES display_type(id_display_type) " +
                            "ON DELETE SET NULL " +
                            "ON UPDATE CASCADE"
            ))
    @JsonView({Views.FullModel.class, Views.FullSmartPhone.class})
    private DisplayType displayType;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_resolution",
            foreignKey = @ForeignKey(
                    name = "fk_display_resolution",
                    foreignKeyDefinition = "FOREIGN KEY (id_resolution) REFERENCES resolution(id_resolution) " +
                            "ON DELETE SET NULL " +
                            "ON UPDATE CASCADE"
            ))
    @JsonView({Views.FullModel.class, Views.FullSmartPhone.class})
    private Resolution resolution;
    @JsonView({Views.FullModel.class, Views.FullSmartPhone.class})
    private Float diagonal;
    @JsonView({Views.FullModel.class, Views.FullSmartPhone.class})
    private Integer density;

    public Display() {
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

    public DisplayType getDisplayType() {
        return displayType;
    }

    public void setDisplayType(DisplayType displayType) {
        this.displayType = displayType;
    }

    public Float getDiagonal() {
        return diagonal;
    }

    public void setDiagonal(float diagonal) {
        this.diagonal = diagonal;
    }

    public Integer getDensity() {
        return density;
    }

    public void setDensity(int density) {
        this.density = density;
    }

    public Resolution getResolution() {
        return resolution;
    }

    public void setResolution(Resolution resolution) {
        this.resolution = resolution;
    }
}
