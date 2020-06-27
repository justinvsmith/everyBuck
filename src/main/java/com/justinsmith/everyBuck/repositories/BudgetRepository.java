package com.justinsmith.everyBuck.repositories;

import java.util.List;
import java.util.Optional;

import org.springframework.data.repository.CrudRepository;

import com.justinsmith.everyBuck.models.Budget;

public interface BudgetRepository extends CrudRepository<Budget, Long> {
	List<Budget> findAll();
	
	Optional<Budget> findById(Long id);
}
