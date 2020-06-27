package com.justinsmith.everyBuck.repositories;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import com.justinsmith.everyBuck.models.Transaction;

public interface TransactionRepository extends CrudRepository<Transaction, Long> {
	List<Transaction> findAll();
	
	
	Optional<Transaction> findById(Long id);
	
	@Query(value="SELECT sum(amount) FROM everyDollar.transactions WHERE item_id = :itemId ;", nativeQuery=true)
	Transaction sumTransactions(@Param("itemId")Long id);
}
