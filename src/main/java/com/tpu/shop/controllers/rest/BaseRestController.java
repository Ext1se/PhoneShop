package com.tpu.shop.controllers.rest;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public abstract class BaseRestController<R extends JpaRepository<T, Long>, T> {

    protected R repository;

    public BaseRestController(R repository) {
        this.repository = repository;
    }

    @GetMapping
    public List<T> get() {
        //List<T> objects = repository.findAll();
        return repository.findAll();
    }

    @PostMapping
    public T post(@RequestBody T object) {
        return repository.save(object);
    }

    @PutMapping("{id}")
    public T update(@RequestBody T object, @PathVariable Long id) {
        return repository.save(object);
    }

    @DeleteMapping("{id}")
    public void delete(@PathVariable Long id) {
        repository.deleteById(id);
    }
}
