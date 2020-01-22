package com.tpu.shop.repository;

import com.tpu.shop.data.Os;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OsRepository extends JpaRepository<Os, Long> {
    Os findByName(String name);
}
