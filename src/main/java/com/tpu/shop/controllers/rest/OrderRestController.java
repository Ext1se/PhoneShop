package com.tpu.shop.controllers.rest;

import com.fasterxml.jackson.annotation.JsonView;
import com.tpu.shop.data.*;
import com.tpu.shop.repository.*;
import com.tpu.shop.service.MailSender;
import com.tpu.shop.utils.PreOrder;
import com.tpu.shop.utils.ProductLine;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;


@RestController
@RequestMapping("/api")
public class OrderRestController {

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private AddressRepository addressRepository;

    @Autowired
    private BucketRepository bucketRepository;

    @Autowired
    private DeliveryRepository deliveryRepository;

    @Autowired
    private MailSender mailSender;

    @GetMapping("/orders/")
    @JsonView({Views.Order.class})
    public List<Order> getOrders() {
        return orderRepository.findAll(new Sort(Sort.Direction.DESC, "id"));
    }

    @GetMapping("/orders/{id}")
    @JsonView({Views.Order.class})
    public Order getOrder(@PathVariable Long id) {
        return orderRepository.findById(id).get();
    }

    @PutMapping("/order/{id}/state/{state}")
    public void setOrderState(@PathVariable("id") Order order, @PathVariable("state") String state) {
        OrderState orderState = OrderState.IDLE;
        String stateMessage = "";
        switch (state) {
            case "IDLE":
                orderState = OrderState.IDLE;
                stateMessage = "принят.";
                break;
            case "PROGRESS":
                orderState = OrderState.PROGRESS;
                stateMessage = "одобрен и выполняется.";
                break;
            case "COMPLETED":
                orderState = OrderState.COMPLETED;
                stateMessage = "выполнен!";
                order.setDateCompleted(LocalDateTime.now());
                break;
            case "NEGATIVE":
                orderState = OrderState.NEGATIVE;
                stateMessage = "отклонен.";
                break;
            case "POSITIVE":
                orderState = OrderState.POSITIVE;
                stateMessage = "одобрен!";
                break;
            default:
                orderState = OrderState.IDLE;
                stateMessage = "принят.";
                break;
        }

        order.setState(orderState);
        orderRepository.save(order);

        User user = order.getUser();
        if (!StringUtils.isEmpty(user.getEmail())) {
            String message = String.format(
                    "Здравствуйте, %s! \n" +
                            "Ваш заказ %s \n" +
                            "http://localhost:8080/orders/%s",
                    user.getUsername(),
                    stateMessage,
                    order.getId()
            );

            mailSender.send(user.getEmail(), "Super Gadget", message);
        }
    }

    @GetMapping("/orders-user/")
    @JsonView({Views.Order.class})
    public List<Order> getUserOrders(@AuthenticationPrincipal User user) {
        return orderRepository.findByUserIdOrderByIdDesc(user.getId());
    }

    private List<Long> getIds(List<SmartPhone> smartPhones) {
        return smartPhones.stream().map(SmartPhone::getId).collect(Collectors.toList());
    }

    @PostMapping("/bucket-product/")
    public List<Long> addProduct(@RequestBody SmartPhone newSmartPhone, @AuthenticationPrincipal User user) {
        for (SmartPhone smartPhone : user.getSmartPhones()) {
            if (smartPhone.getId().longValue() == newSmartPhone.getId().longValue()) {
                return getIds(user.getSmartPhones());
            }
        }
        user.addSmartPhone(newSmartPhone);
        return getIds(user.getSmartPhones());
        //return orderRepository.findByUserId(user.getId());
    }

    @GetMapping("/bucket-product/")
    public List<Long> getProducts(@AuthenticationPrincipal User user) {
        return getIds(user.getSmartPhones());
    }

    @GetMapping("/order-products/")
    public List<SmartPhone> getSmartPhones(@AuthenticationPrincipal User user) {
        return user.getSmartPhones();
    }

    @PostMapping("/order/")
    public void saveOrder(@RequestBody PreOrder preOrder, @AuthenticationPrincipal User user) {
        Order order = new Order();
        Delivery delivery = null;
        if (preOrder.getTypeDelivery().intValue() > 0) {
            delivery = deliveryRepository.findByName("Доставка");
            order.setDateDelivery(preOrder.getDateDelivery());

            Address address = preOrder.getAddress();
            address.setId(null);
            Address existAddress =
                    addressRepository.findByCityAndStreetAndHouseAndApartment(
                            address.getCity(),
                            address.getStreet(),
                            address.getHouse(),
                            address.getApartment());
            if (existAddress != null) {
                preOrder.setAddress(existAddress);
            } else {
                address = addressRepository.save(address);
                preOrder.setAddress(address);
            }
            order.setAddress(preOrder.getAddress());

        } else {
            delivery = deliveryRepository.findByName("Самовывоз");
            order.setAddress(null);
        }
        order.setDelivery(delivery);
        order.setFullSum(preOrder.getSum());
        order.setDateOrder(LocalDateTime.now());
        order.setState(OrderState.IDLE);
        order.setPhoneNumber(preOrder.getPhoneNumber());
        order.setUser(user);

        order = orderRepository.save(order);
        for (ProductLine productLine : preOrder.getProductLines()) {
            Bucket bucket = new Bucket();
            BucketId bucketId = new BucketId();
            bucketId.setIdOrder(order.getId());
            bucketId.setIdSmartPhone(productLine.getSmartPhone().getId());
            bucket.setId(bucketId);
            bucket.setOrder(order);
            bucket.setSmartPhone(productLine.getSmartPhone());
            bucket.setCount(productLine.getCount());
            bucketRepository.save(bucket);
        }

        user.getSmartPhones().clear();

        if (!StringUtils.isEmpty(user.getEmail())) {
            String message = String.format(
                    "Здравствуйте, %s! \n" +
                            "Ваш заказ принят. \n" +
                            "http://localhost:8080/orders/%s",
                    user.getUsername(),
                    order.getId()
            );

            mailSender.send(user.getEmail(), "Super Gadget", message);
        }
    }

    @DeleteMapping("/order-products/{id}")
    public void deleteSmartPhoneFromOrder(@PathVariable("id") SmartPhone smartPhone,
                                          @AuthenticationPrincipal User user) {
        user.getSmartPhones().removeIf(item -> item.getId().longValue() == smartPhone.getId().longValue());

    }

    @DeleteMapping("/orders/{id}")
    public void deleteOrder(@PathVariable Long id) {
        orderRepository.deleteById(id);
    }
}
