package com.tpu.shop.repository;

import com.tpu.shop.data.Camera;
import com.tpu.shop.data.Gpu;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CameraRepository extends JpaRepository<Camera, Long> {
    Camera findByName(String name);
}
