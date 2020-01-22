package com.tpu.shop.repository;

import com.tpu.shop.data.Color;
import com.tpu.shop.data.Company;
import com.tpu.shop.data.Model;
import com.tpu.shop.data.SmartPhone;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Collection;
import java.util.List;

public interface SmartPhoneRepository extends JpaRepository<SmartPhone, Long> {

    @Query("select p from SmartPhone p " +
            "where p.colorModel.color in :colors and " +
            "p.colorModel.model.company in :companies " +
            "order by p.id desc")
    List<SmartPhone> findPhonesByFilter(
            @Param("colors") Collection<Color> colors,
            @Param("companies")Collection<Company> companies);


    @Query("select p from SmartPhone p " +
            "where lower(p.colorModel.model.name) like lower(concat('%', :name,'%')) " +
            "order by p.id desc")
    List<SmartPhone> findByName(@Param("name") String name);

    @Query("select p from SmartPhone p " +
            "where p.colorModel.model.id = :id " +
            "order by p.id desc")
    List<SmartPhone> findByModelId(@Param("id") Long idModel);


  /*  @Query("select p from SmartPhone p " +
            "where :query " +
            "order by p.id desc")
    List<SmartPhone> findPhonesByFilters(
            @Param("query") String query,
            @Param("colors") Collection<Color> colors,
            @Param("companies")Collection<Company> companies);*/
}
