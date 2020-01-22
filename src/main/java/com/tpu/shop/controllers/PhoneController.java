package com.tpu.shop.controllers;

import com.tpu.shop.data.SmartPhone;
import com.tpu.shop.repository.ModelColorRepository;
import com.tpu.shop.repository.ModelRepository;
import com.tpu.shop.repository.SmartPhoneRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
public class PhoneController {

    @Autowired
    private ModelRepository modelRepository;

    @Autowired
    private SmartPhoneRepository smartPhoneRepository;

    @Autowired
    private ModelColorRepository modelColorRepository;

    @GetMapping("/")
    public String getSmartPhones(){
        return "phones";
    }

    @GetMapping("/phone/{id}")
    public String getModelById(@PathVariable("id") SmartPhone smartPhone, Model model){
        model.addAttribute("idPhone", smartPhone.getId());
        model.addAttribute("idModel", smartPhone.getColorModel().getModel().getId());
        return "phone";
    }
}
