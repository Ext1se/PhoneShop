package com.tpu.shop.repository;

import com.tpu.shop.data.Color;
import com.tpu.shop.data.DisplayType;
import com.tpu.shop.data.Resolution;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ResolutionRepository extends JpaRepository<Resolution, Long> {
    @Query("select resolution from Resolution resolution order by (resolution.resolutionX * resolution.resolutionY)")
    List<Resolution> findAllSortByResolutions();
}
