package com.tpu.shop.repository;

import com.tpu.shop.data.ModelColor;
import org.springframework.data.jpa.repository.JpaRepository;


public interface ModelColorRepository extends JpaRepository<ModelColor, Long> {

    ModelColor findColorModelById(Long id);

}
