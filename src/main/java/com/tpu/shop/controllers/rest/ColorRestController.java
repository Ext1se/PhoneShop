package com.tpu.shop.controllers.rest;

import com.tpu.shop.data.Color;
import com.tpu.shop.data.Cpu;
import com.tpu.shop.repository.ColorRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/colors")
public class ColorRestController extends BaseRestController<ColorRepository, Color>{

    public ColorRestController(ColorRepository repository){
        super(repository);
    }

    @Override
    public List<Color> get() {
        return super.get();
    }
}
