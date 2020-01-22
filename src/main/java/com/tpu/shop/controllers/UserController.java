package com.tpu.shop.controllers;

import com.tpu.shop.data.Address;
import com.tpu.shop.data.User;
import com.tpu.shop.repository.AddressRepository;
import com.tpu.shop.service.UserService;
import com.tpu.shop.utils.StringUtils;
import com.tpu.shop.utils.ValidationMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.Map;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    UserService userService;

    @Autowired
    AddressRepository addressRepository;

    @GetMapping("profile")
    public String getProfile(Model model, @AuthenticationPrincipal User user) {
        model.addAttribute("user", user);
        return "profile";
    }

    @PostMapping("/profile")
    public String updateProfile(
            @AuthenticationPrincipal User authUser,
            @Valid User userEdit,
            BindingResult bindingResult,
            Model model
    ) {

        if (bindingResult.hasErrors()) {
            Map<String, String> errors = ControllerUtils.getErrors(bindingResult);
            if (errors.containsKey("firstNameError") || errors.containsKey("lastNameError")) {
                model.mergeAttributes(errors);
                return "profile";
            }
        }

        Address address = userEdit.getAddress();
        if (address != null) {
            if (address.isCompleted()) {
                Address existAddress = addressRepository.findByCityAndStreetAndHouseAndApartment(address.getCity(), address.getStreet(), address.getHouse(), address.getApartment());
                if (existAddress != null) {
                    authUser.setAddress(existAddress);
                } else {
                    address = addressRepository.save(address);
                    authUser.setAddress(address);
                }
            } else {
                if (address.isEmpty()) {
                    authUser.setAddress(null);
                } else {
                    if (!StringUtils.checkString(address.getCity())) {
                        model.addAttribute("addressCityError", ValidationMessage.EMPTY_FIELD);
                    }
                    if (!StringUtils.checkString(address.getStreet())) {
                        model.addAttribute("addressStreetError", ValidationMessage.EMPTY_FIELD);
                    }
                    if (!StringUtils.checkString(address.getHouse())) {
                        model.addAttribute("addressHouseError", ValidationMessage.EMPTY_FIELD);
                    }
                    if (!StringUtils.checkString(address.getApartment())) {
                        model.addAttribute("addressApartmentError", ValidationMessage.EMPTY_FIELD);
                    }
                    model.addAttribute("addressError", "Чтобы указать адрес, заполните все поля, или оставьте их пустыми.");
                    return "profile";
                }
            }
        }


        authUser.setFirstName(userEdit.getFirstName());
        authUser.setLastName(userEdit.getLastName());
        authUser.setPhoneNumber(userEdit.getPhoneNumber());
        if (!authUser.getEmail().equalsIgnoreCase(userEdit.getEmail())){
            authUser.setEmail(userEdit.getEmail());
        }
        userService.updateProfile(authUser);
        //return "profile";
        return "redirect:/";
    }
}
