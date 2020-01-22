package com.tpu.shop.controllers.rest;

import com.tpu.shop.data.Resolution;
import com.tpu.shop.repository.ResolutionRepository;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/resolutions")
public class ResolutionRestController extends BaseRestController<ResolutionRepository, Resolution> {

    public ResolutionRestController(ResolutionRepository repository) {
        super(repository);
    }

    @Override
    public List<Resolution> get() {
        return repository.findAllSortByResolutions();
    }
}
