package com.tpu.shop.repository;


import com.tpu.shop.data.Role;
import com.tpu.shop.data.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RoleRepository extends JpaRepository<Role, Long> {
    Role findByName(String name);
}
