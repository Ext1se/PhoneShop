package com.tpu.shop.repository;

import com.tpu.shop.data.Color;
import com.tpu.shop.data.Os;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ColorRepository extends JpaRepository<Color, Long> {
    Color findByName(String name);
}
