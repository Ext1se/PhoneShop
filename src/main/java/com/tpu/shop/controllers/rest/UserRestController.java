package com.tpu.shop.controllers.rest;

import com.fasterxml.jackson.annotation.JsonView;
import com.tpu.shop.data.Order;
import com.tpu.shop.data.SmartPhone;
import com.tpu.shop.data.User;
import com.tpu.shop.data.Views;
import com.tpu.shop.repository.OrderRepository;
import com.tpu.shop.utils.PreOrder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;


@RestController
@RequestMapping("/api/user/")
public class UserRestController {

    @GetMapping
    @JsonView({Views.User.class})
    public User getUser(@AuthenticationPrincipal User user) {
        return user;
    }

}
