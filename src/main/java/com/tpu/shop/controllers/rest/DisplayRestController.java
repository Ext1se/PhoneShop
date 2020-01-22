package com.tpu.shop.controllers.rest;

import com.tpu.shop.data.Display;
import com.tpu.shop.data.Os;
import com.tpu.shop.repository.DisplayRepository;
import com.tpu.shop.repository.OsRepository;
import com.tpu.shop.utils.RestException;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/displays")
public class DisplayRestController extends BaseRestController<DisplayRepository, Display> {

    public DisplayRestController(DisplayRepository repository) {
        super(repository);
    }

}
