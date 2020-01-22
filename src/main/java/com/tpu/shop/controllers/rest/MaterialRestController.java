package com.tpu.shop.controllers.rest;

import com.tpu.shop.data.Material;
import com.tpu.shop.data.Os;
import com.tpu.shop.repository.MaterialRepository;
import com.tpu.shop.repository.OsRepository;
import com.tpu.shop.utils.RestException;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/materials")
public class MaterialRestController extends BaseRestController<MaterialRepository, Material> {

    private final String errorMessage = "Название такого материала уже существует!";

    public MaterialRestController(MaterialRepository repository) {
        super(repository);
    }

    @Override
    public Material post(@RequestBody Material object) {
        if (repository.findByName(object.getName()) != null) {
            throw new RestException(errorMessage);
        }
        return super.post(object);
    }

    @Override
    public Material update(@RequestBody Material object, Long id) {
        Material existObject = repository.findByName(object.getName());
        if (existObject != null && !(existObject.getId().equals(object.getId()))) {
            throw new RestException(errorMessage);
        }
        return super.update(object, id);
    }
}
