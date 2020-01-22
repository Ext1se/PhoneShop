package com.tpu.shop.repository;

import com.tpu.shop.data.Material;
import com.tpu.shop.data.Os;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MaterialRepository extends JpaRepository<Material, Long> {
    Material findByName(String name);
}
