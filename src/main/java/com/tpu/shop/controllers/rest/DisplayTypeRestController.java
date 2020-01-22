package com.tpu.shop.controllers.rest;

import com.tpu.shop.data.DisplayType;
import com.tpu.shop.repository.DisplayTypeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/display-types")
public class DisplayTypeRestController extends BaseRestController<DisplayTypeRepository, DisplayType>{

    public DisplayTypeRestController(DisplayTypeRepository repository) {
        super(repository);
    }
}
