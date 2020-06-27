package com.justinsmith.everyBuck.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.justinsmith.everyBuck.models.User;

public interface UserRepository extends CrudRepository<User, Long> {
	List<User> findAll();
	
	User findByEmail(String search);
	
	User findById(String search);
}
