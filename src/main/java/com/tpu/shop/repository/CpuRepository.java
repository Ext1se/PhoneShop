package com.tpu.shop.repository;

import com.tpu.shop.data.Cpu;
import com.tpu.shop.data.Gpu;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CpuRepository extends JpaRepository<Cpu, Long> {
    Cpu findByName(String name);
}
