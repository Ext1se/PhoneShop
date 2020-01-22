package com.tpu.shop.controllers;

import com.tpu.shop.repository.ModelRepository;
import com.tpu.shop.repository.TestCpulRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
@PreAuthorize("hasAuthority('ADMIN')")
public class ModelController {

    @Autowired
    private ModelRepository repository;

    @GetMapping("/admin/model")
    public String getModel(){
        return "model";
    }

    @GetMapping("/admin/models")
    public String getModels(){
        return "models";
    }

    @GetMapping("/admin/smartphones")
    public String getSmartPhones(){
        return "smartphones";
    }

    @GetMapping("/admin/model/{id}")
    public String getModelById(@PathVariable Long id, Model model){
        model.addAttribute("model", model);
        model.addAttribute("id", id);
        return "model";
    }
}
