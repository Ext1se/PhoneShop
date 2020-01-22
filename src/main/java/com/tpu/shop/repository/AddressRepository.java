package com.tpu.shop.repository;


import com.tpu.shop.data.Address;
import com.tpu.shop.data.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AddressRepository extends JpaRepository<Address, Long> {

    Address findByCityAndStreetAndHouseAndApartment(String city, String street, String house, String apartment);

}
