package com.tpu.shop.data;

import com.fasterxml.jackson.annotation.JsonView;
import org.hibernate.validator.constraints.Length;

import javax.persistence.*;
import java.util.List;

// Для REST использовать жадный fetch = FetchType.EAGER,
// иначе дополнительные зависимости загружаться не будут
@Entity
@Table(name = "model")
public class Model {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_model")
    @JsonView({Views.Base.class, Views.FullModel.class, Views.FullSmartPhone.class})
    private Long id;

    @Length(max = 200)
    @Column(nullable = false, unique = true)
    @JsonView({Views.FullModel.class, Views.FullSmartPhone.class})
    private String name;

    @ManyToOne(targetEntity = Company.class, fetch = FetchType.EAGER)
    @JoinColumn(name = "id_company",
            foreignKey = @ForeignKey(
                    name = "fk_model_company",
                    foreignKeyDefinition = "FOREIGN KEY (id_company) REFERENCES company(id_company) " +
                            "ON DELETE SET NULL " +
                            "ON UPDATE CASCADE"
            ))
    @JsonView({Views.FullModel.class, Views.FullSmartPhone.class})
    private Company company;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_cpu",
            foreignKey = @ForeignKey(
                    name = "fk_model_cpu",
                    foreignKeyDefinition = "FOREIGN KEY (id_cpu) REFERENCES cpu(id_cpu) " +
                            "ON DELETE SET NULL " +
                            "ON UPDATE CASCADE"))
    @JsonView({Views.FullModel.class, Views.FullSmartPhone.class})
    private Cpu cpu;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_gpu",
            foreignKey = @ForeignKey(
                    name = "fk_model_gpu",
                    foreignKeyDefinition = "FOREIGN KEY (id_gpu) REFERENCES gpu(id_gpu) " +
                            "ON DELETE SET NULL " +
                            "ON UPDATE CASCADE"))
    @JsonView({Views.FullModel.class, Views.FullSmartPhone.class})
    private Gpu gpu;

    @ManyToOne(targetEntity = Camera.class, fetch = FetchType.EAGER)
    @JoinColumn(name = "id_camera_main", nullable = true,
            foreignKey = @ForeignKey(
                    name = "fk_model_camera_main",
                    foreignKeyDefinition = "FOREIGN KEY (id_camera_main) REFERENCES camera(id_camera) " +
                            "ON UPDATE CASCADE " +
                            "ON DELETE SET NULL"
            ))
    @JsonView({Views.FullModel.class, Views.FullSmartPhone.class})
    private Camera mainCamera;


    @ManyToOne(targetEntity = Camera.class, fetch = FetchType.EAGER)
    @JoinColumn(name = "id_camera_add", nullable = true,
            foreignKey = @ForeignKey(
                    name = "fk_model_camera_add",
                    foreignKeyDefinition = "FOREIGN KEY (id_camera_add) REFERENCES camera(id_camera) " +
                            "ON UPDATE CASCADE " +
                            "ON DELETE SET NULL"
            ))
    @JsonView({Views.FullModel.class, Views.FullSmartPhone.class})
    private Camera addCamera;

    @ManyToOne(targetEntity = Display.class, fetch = FetchType.EAGER)
    @JoinColumn(name = "id_display",
            foreignKey = @ForeignKey(
                    name = "fk_model_display",
                    foreignKeyDefinition = "FOREIGN KEY (id_display) REFERENCES display(id_display) " +
                            "ON UPDATE CASCADE " +
                            "ON DELETE SET NULL"
            ))
    @JsonView({Views.FullModel.class, Views.FullSmartPhone.class})
    private Display display;

    @ManyToOne(targetEntity = Material.class, fetch = FetchType.EAGER)
    @JoinColumn(name = "id_material",
            foreignKey = @ForeignKey(
                    name = "fk_model_material",
                    foreignKeyDefinition = "FOREIGN KEY (id_material) REFERENCES material(id_material) " +
                            "ON UPDATE CASCADE " +
                            "ON DELETE SET NULL"
            ))
    @JsonView({Views.FullModel.class, Views.FullSmartPhone.class})
    private Material material;

    @JsonView({Views.FullModel.class, Views.FullSmartPhone.class})
    private Integer weight;
    @JsonView({Views.FullModel.class, Views.FullSmartPhone.class})
    private Integer height;
    @JsonView({Views.FullModel.class, Views.FullSmartPhone.class})
    private Integer width;
    @JsonView({Views.FullModel.class, Views.FullSmartPhone.class})
    private Integer countSim;
    @JsonView({Views.FullModel.class, Views.FullSmartPhone.class})
    private Integer power;

    @Column(columnDefinition = "TEXT")
    @JsonView({Views.FullModel.class, Views.FullSmartPhone.class})
    private String description;


    @OneToMany(mappedBy = "model", targetEntity = ModelColor.class, fetch = FetchType.EAGER)
    @JsonView(Views.FullModel.class)
    private List<ModelColor> colorModels;

    public Model() {

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

    public Cpu getCpu() {
        return cpu;
    }

    public void setCpu(Cpu cpu) {
        this.cpu = cpu;
    }

    public Gpu getGpu() {
        return gpu;
    }

    public void setGpu(Gpu gpu) {
        this.gpu = gpu;
    }

    public Camera getMainCamera() {
        return mainCamera;
    }

    public void setMainCamera(Camera mainCamera) {
        this.mainCamera = mainCamera;
    }

    public Camera getAddCamera() {
        return addCamera;
    }

    public void setAddCamera(Camera addCamera) {
        this.addCamera = addCamera;
    }

    public Company getCompany() {
        return company;
    }

    public void setCompany(Company company) {
        this.company = company;
    }

    public Display getDisplay() {
        return display;
    }

    public void setDisplay(Display display) {
        this.display = display;
    }

    public Material getMaterial() {
        return material;
    }

    public void setMaterial(Material material) {
        this.material = material;
    }

    public Integer getWeight() {
        return weight;
    }

    public void setWeight(int weight) {
        this.weight = weight;
    }

    public Integer getHeight() {
        return height;
    }

    public void setHeight(int height) {
        this.height = height;
    }

    public Integer getWidth() {
        return width;
    }

    public void setWidth(int width) {
        this.width = width;
    }

    public Integer getCountSim() {
        return countSim;
    }

    public void setCountSim(int countSim) {
        this.countSim = countSim;
    }

    public Integer getPower() {
        return power;
    }

    public void setPower(int power) {
        this.power = power;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setWeight(Integer weight) {
        this.weight = weight;
    }

    public void setHeight(Integer height) {
        this.height = height;
    }

    public void setWidth(Integer width) {
        this.width = width;
    }

    public void setCountSim(Integer countSim) {
        this.countSim = countSim;
    }

    public void setPower(Integer power) {
        this.power = power;
    }

    public List<ModelColor> getColorModels() {
        return colorModels;
    }

    public void setColorModels(List<ModelColor> colorModels) {
        this.colorModels = colorModels;
    }
}
