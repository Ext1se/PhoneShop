package com.tpu.shop.controllers.rest;

import com.tpu.shop.data.Camera;
import com.tpu.shop.repository.CameraRepository;
import com.tpu.shop.utils.RestException;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/cameras")
public class CameraRestController extends BaseRestController<CameraRepository, Camera> {

    private final String errorMessage = "Камера с таким названием уже существует!";

    public CameraRestController(CameraRepository repository) {
        super(repository);
    }

    @Override
    public Camera post(@RequestBody Camera object) {
        if (repository.findByName(object.getName()) != null) {
            throw new RestException(errorMessage);
        }
        return super.post(object);
    }

    @Override
    public Camera update(@RequestBody Camera object, Long id) {
        Camera existObject = repository.findByName(object.getName());
        if (existObject != null && !(existObject.getId().equals(object.getId()))) {
            throw new RestException(errorMessage);
        }
        return super.update(object, id);
    }
}
