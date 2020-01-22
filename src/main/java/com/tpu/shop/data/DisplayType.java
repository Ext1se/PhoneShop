package com.tpu.shop.data;

import com.fasterxml.jackson.annotation.JsonView;
import com.tpu.shop.utils.ValidationMessage;
import org.hibernate.validator.constraints.Length;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;

@Entity
@Table(name = "display_type")
public class DisplayType {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_display_type")
    @JsonView({Views.FullModel.class, Views.FullSmartPhone.class})
    private Long id;

    @NotBlank(message = ValidationMessage.EMPTY_FIELD)
    @Length(max = 40)
    @Column(nullable = false)
    @JsonView({Views.FullModel.class, Views.FullSmartPhone.class})
    private String name;

    public DisplayType() {
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
}
