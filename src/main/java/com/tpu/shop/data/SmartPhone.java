package com.tpu.shop.data;

import com.fasterxml.jackson.annotation.JsonView;

import javax.persistence.*;

@Entity
@Table(name = "product")
public class SmartPhone {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_product")
    @JsonView({Views.FullModel.class, Views.FullSmartPhone.class})
    private Long id;

    @ManyToOne(targetEntity = Os.class, fetch = FetchType.EAGER)
    @JoinColumn(name = "id_os",
            foreignKey = @ForeignKey(
                    name = "fk_product_os",
                    foreignKeyDefinition = "FOREIGN KEY (id_os) REFERENCES os(id_os) " +
                            "ON DELETE SET NULL " +
                            "ON UPDATE CASCADE"
            ))
    @JsonView({Views.FullModel.class, Views.FullSmartPhone.class})
    private Os os;

    @ManyToOne(targetEntity = ModelColor.class, fetch = FetchType.EAGER)
    @JoinColumn(name = "id_model_color",
            foreignKey = @ForeignKey(
                    name = "fk_product_model_color",
                    foreignKeyDefinition = "FOREIGN KEY (id_model_color) REFERENCES model_color(id_model_color) " +
                            "ON UPDATE CASCADE " +
                            "ON DELETE CASCADE"
            ))
    @JsonView(Views.FullSmartPhone.class)
    private ModelColor colorModel;

    @JsonView({Views.FullModel.class, Views.FullSmartPhone.class})
    private Integer storage;
    @JsonView({Views.FullModel.class, Views.FullSmartPhone.class})
    private Integer ram;
    @JsonView({Views.FullModel.class, Views.FullSmartPhone.class})
    private Integer cost;
    @JsonView({Views.FullModel.class, Views.FullSmartPhone.class})
    private Integer count;

    public SmartPhone() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Os getOs() {
        return os;
    }

    public void setOs(Os os) {
        this.os = os;
    }

    public ModelColor getColorModel() {
        return colorModel;
    }

    public void setColorModel(ModelColor colorModel) {
        this.colorModel = colorModel;
    }

    public Integer getStorage() {
        return storage;
    }

    public void setStorage(int storage) {
        this.storage = storage;
    }

    public Integer getRam() {
        return ram;
    }

    public void setRam(int ram) {
        this.ram = ram;
    }

    public Integer getCost() {
        return cost;
    }

    public void setCost(int cost) {
        this.cost = cost;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }
}
