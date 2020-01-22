package com.tpu.shop.repository;

import com.tpu.shop.data.*;
import com.tpu.shop.data.Model;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Collection;
import java.util.List;

public interface ModelRepository extends JpaRepository<Model, Long> {

    Model findModelById(Long id);
    Model findByName(String name);

    @Query("select m from Model m " +
            "where lower(m.name) like lower(concat('%', :name,'%')) " +
            "order by m.id desc")
    List<Model> findByLikeName(@Param("name") String name);

    Page<Model> findAll(Pageable pageable);

/*    @Query("select m from Model m " +
            "where m in (select mc FROM ModelColor mc where mc.color in :colors) " +
            "order by model.id desc")
    List<Model> findModelsByFilter(@Param("companies") Collection<Company> companies,
                                   @Param("colors") Collection<Color> colors);*/


}
