package com.tpu.shop.controllers.rest;

import com.tpu.shop.data.Company;
import com.tpu.shop.data.Material;
import com.tpu.shop.repository.CompanyRepository;
import com.tpu.shop.repository.MaterialRepository;
import com.tpu.shop.utils.RestException;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/companies")
public class CompanyRestController extends BaseRestController<CompanyRepository, Company> {

    private final String errorMessage = "Компания с таким названием уже существует!";

    public CompanyRestController(CompanyRepository repository) {
        super(repository);
    }

    @Override
    public Company post(@RequestBody Company object) {
        if (repository.findByName(object.getName()) != null) {
            throw new RestException(errorMessage);
        }
        return super.post(object);
    }

    @Override
    public Company update(@RequestBody Company object, Long id) {
        Company existObject = repository.findByName(object.getName());
        if (existObject != null && !(existObject.getId().equals(object.getId()))) {
            throw new RestException(errorMessage);
        }
        return super.update(object, id);
    }
}
