package com.tpu.shop.repository;

import com.tpu.shop.data.Delivery;
import org.springframework.data.jpa.repository.JpaRepository;

public interface DeliveryRepository extends JpaRepository<Delivery, Long> {

    Delivery findByName(String name);
}
