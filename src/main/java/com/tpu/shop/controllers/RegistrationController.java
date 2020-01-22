package com.tpu.shop.controllers;

import com.tpu.shop.data.User;
import com.tpu.shop.service.UserService;
import com.tpu.shop.utils.ValidationMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.validation.Valid;
import java.util.Map;

@Controller
public class RegistrationController {
    @Autowired
    private UserService userService;

    @GetMapping("/registration")
    public String registration() {
        return "registration";
    }

    @PostMapping("/registration")
    public String addUser(
            @RequestParam("confirmPassword") String confirmPassword,
            @Valid User user,
            BindingResult bindingResult,
            Model model
    ) {

        boolean isConfirmEmpty = confirmPassword.isEmpty();
        boolean isConfirmPassword = user.getPassword().equals(confirmPassword);
        if (isConfirmEmpty) {
            model.addAttribute("confirmPasswordError", ValidationMessage.EMPTY_FIELD);
        }

        if (!isConfirmPassword) {
            model.addAttribute("passwordError", "Пароли не совпадают");
        }

        if (!isConfirmPassword || isConfirmEmpty || bindingResult.hasErrors()) {
            Map<String, String> errors = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errors);
            return "registration";
        }

        if (!userService.addUser(user)) {
            model.addAttribute("usernameError", "Пользователь с таким именем уже существует!");
            return "registration";
        }

        return "redirect:/login";
    }

    @GetMapping("/activate/{code}")
    public String activate(Model model, @PathVariable String code) {
        boolean isActivated = userService.activateUser(code);

        if (isActivated) {
            model.addAttribute("messageType", "success");
            model.addAttribute("message", "Пользователь успешно зарегистрирован");
        } else {
            model.addAttribute("messageType", "danger");
            model.addAttribute("message", "Код активации не найден!");
        }

        return "login";
    }
}
