package com.tpu.shop.controllers;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@PreAuthorize("hasAuthority('ADMIN')")
public class ComponentController {

    @GetMapping("/admin/oss")
    public String getOs() {
        return "oss";
    }

    @GetMapping("/admin/colors")
    public String getColors() {
        return "colors";
    }

    @GetMapping("/admin/display-types")
    public String getDisplayTypes() {
        return "display-types";
    }

    @GetMapping("/admin/resolutions")
    public String getResolutions(){
        return "resolutions";
    }

    @GetMapping("/admin/companies")
    public String getCompanies(){
        return "companies";
    }

    @GetMapping("/admin/cameras")
    public String getCameras(){
        return "cameras";
    }

    @GetMapping("/admin/materials")
    public String getMaterials(){
        return "materials";
    }

    @GetMapping("/admin/displays")
    public String getDisplays(){
        return "displays";
    }

    @GetMapping("/admin/gpunits")
    public String getGPUs(){
        return "gpunits";
    }

    @GetMapping("/admin/cpunits")
    public String getCPUs(){
        return "cpunits";
    }
}
