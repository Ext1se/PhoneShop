package com.tpu.shop.controllers.rest;

import com.tpu.shop.data.Os;
import com.tpu.shop.data.Resolution;
import com.tpu.shop.repository.OsRepository;
import com.tpu.shop.repository.ResolutionRepository;
import com.tpu.shop.utils.RestException;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/oss")
public class OsRestController extends BaseRestController<OsRepository, Os> {

    public OsRestController(OsRepository repository) {
        super(repository);
    }

    @Override
    public Os post(@RequestBody Os object) {
        checkExistName(object);
        return super.post(object);
    }

    @Override
    public Os update(@RequestBody Os object, Long id) {
        checkExistName(object);
        return super.update(object, id);
    }

    private void checkExistName(Os object){
        if (repository.findByName(object.getName()) != null) {
            throw new RestException("Название такой операционной системы уже существует!");
        }
    }
}
