package com.tpu.shop.repository;

import com.tpu.shop.data.Display;
import com.tpu.shop.data.Os;
import org.springframework.data.jpa.repository.JpaRepository;

public interface DisplayRepository extends JpaRepository<Display, Long> {
    Display findByName(String name);
}
