package com.tpu.shop.controllers.rest;

import com.tpu.shop.data.Cpu;
import com.tpu.shop.repository.CpuRepository;
import com.tpu.shop.utils.RestException;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/cpunits")
public class CpuRestController extends BaseRestController<CpuRepository, Cpu> {

    private final String errorMessage = "Процессор с таким названием уже существует!";

    public CpuRestController(CpuRepository repository) {
        super(repository);
    }

    @Override
    public Cpu post(@RequestBody Cpu object) {
        if (repository.findByName(object.getName()) != null) {
            throw new RestException(errorMessage);
        }
        return super.post(object);
    }

    @Override
    public Cpu update(@RequestBody Cpu object, Long id) {
        Cpu existObject = repository.findByName(object.getName());
        if (existObject != null && !(existObject.getId().equals(object.getId()))) {
            throw new RestException(errorMessage);
        }
        return super.update(object, id);
    }
}
