package com.tpu.shop.controllers.rest;

import com.tpu.shop.data.Gpu;
import com.tpu.shop.repository.GpuRepository;
import com.tpu.shop.utils.RestException;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/gpunits")
public class GpuRestController extends BaseRestController<GpuRepository, Gpu> {

    private final String errorMessage = "Процессор с таким названием уже существует!";

    public GpuRestController(GpuRepository repository) {
        super(repository);
    }

    @Override
    public Gpu post(@RequestBody Gpu object) {
        if (repository.findByName(object.getName()) != null) {
            throw new RestException(errorMessage);
        }
        return super.post(object);
    }

    @Override
    public Gpu update(@RequestBody Gpu object, Long id) {
        Gpu existObject = repository.findByName(object.getName());
        if (existObject != null && !(existObject.getId().equals(object.getId()))) {
            throw new RestException(errorMessage);
        }
        return super.update(object, id);
    }
}
