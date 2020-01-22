package com.tpu.shop.repository;

import com.tpu.shop.data.Comment;
import com.tpu.shop.data.Order;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface OrderRepository extends JpaRepository<Order, Long> {
    List<Order> findByUserIdOrderByIdDesc(Long idUser);
}
