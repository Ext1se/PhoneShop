package com.tpu.shop.repository;

import com.tpu.shop.data.Gpu;
import org.springframework.data.jpa.repository.JpaRepository;

public interface GpuRepository extends JpaRepository<Gpu, Long> {
    Gpu findByName(String name);
}
