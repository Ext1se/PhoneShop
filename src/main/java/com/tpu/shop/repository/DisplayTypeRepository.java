package com.tpu.shop.repository;

import com.tpu.shop.data.Display;
import com.tpu.shop.data.DisplayType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface DisplayTypeRepository extends JpaRepository<DisplayType, Long> {
    DisplayType findByName(String name);
}
