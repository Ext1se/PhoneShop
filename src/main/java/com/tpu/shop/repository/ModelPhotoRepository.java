package com.tpu.shop.repository;

import com.tpu.shop.data.ModelPhoto;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ModelPhotoRepository extends JpaRepository<ModelPhoto, Long> {

    ModelPhoto findPhotoById(Long id);

}
