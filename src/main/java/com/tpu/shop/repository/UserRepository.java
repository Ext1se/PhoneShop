package com.tpu.shop.repository;


import com.tpu.shop.data.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Long> {

    User findByUsername(String username);

    User findByActivationCode(String code);
    //User findByActivationCode(String code);
}
