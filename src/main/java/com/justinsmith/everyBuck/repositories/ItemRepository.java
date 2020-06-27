package com.justinsmith.everyBuck.repositories;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import com.justinsmith.everyBuck.models.Item;

public interface ItemRepository extends CrudRepository<Item, Long> {
	List<Item> findAll();
	
	
	Optional<Item> findById(Long id);
	
	@Query(value="SELECT * FROM everyDollar.items WHERE category_id = :categoryId ;", nativeQuery=true)
	List<Item> findItemsByCategoryId(@Param("categoryId") Long id);
}
