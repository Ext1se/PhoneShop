package com.tpu.shop.controllers;

import com.tpu.shop.data.Order;
import com.tpu.shop.data.SmartPhone;
import com.tpu.shop.data.User;
import com.tpu.shop.repository.ModelColorRepository;
import com.tpu.shop.repository.ModelRepository;
import com.tpu.shop.repository.OrderRepository;
import com.tpu.shop.repository.SmartPhoneRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

@Controller
public class OrderController {

    @Autowired
    private OrderRepository orderRepository;

    @GetMapping("/bucket/")
    public String getBucket(){
        return "bucket";
    }

    @GetMapping("/orders/{id}")
    public String getOrder(@PathVariable("id") Order order, Model model){
        model.addAttribute("order", order);
        return "order";
    }

    @GetMapping("/orders-user/")
    public String getUserOrders(@AuthenticationPrincipal User user, Model model){
        //List<Order> orders = orderRepository.findByUserIdOrderByIdDesc(user.getId());
        //model.addAttribute("orders", orders);
        return "orders-user";
    }

    @GetMapping("/orders/")
    public String getAllOrders(Model model){
        //List<Order> orders = orderRepository.findAll(new Sort(Sort.Direction.DESC, "id"));
        //model.addAttribute("orders", orders);
        return "orders";
    }
}
