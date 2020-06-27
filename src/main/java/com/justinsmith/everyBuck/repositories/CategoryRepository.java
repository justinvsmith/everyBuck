package com.justinsmith.everyBuck.repositories;

import java.util.List;
import java.util.Optional;

import org.springframework.data.repository.CrudRepository;

import com.justinsmith.everyBuck.models.Category;

public interface CategoryRepository extends CrudRepository<Category, Long> {
	List<Category> findAll();
	
	Optional<Category> findById(Long id);
}
