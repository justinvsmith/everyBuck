package com.justinsmith.everyBuck.services;

import java.util.List;
import java.util.Optional;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.justinsmith.everyBuck.models.Budget;
import com.justinsmith.everyBuck.models.Category;
import com.justinsmith.everyBuck.models.Item;
import com.justinsmith.everyBuck.models.Transaction;
import com.justinsmith.everyBuck.models.User;
import com.justinsmith.everyBuck.repositories.BudgetRepository;
import com.justinsmith.everyBuck.repositories.CategoryRepository;
import com.justinsmith.everyBuck.repositories.ItemRepository;
import com.justinsmith.everyBuck.repositories.TransactionRepository;
import com.justinsmith.everyBuck.repositories.UserRepository;

@Service
public class EveryBuckService {
	User user = null;
	Category category=null;
	Transaction transaction = null;
	Budget budget = null;
	
	@Autowired
	UserRepository userRepo;
	
	@Autowired 
	CategoryRepository categoryRepo;
	
	@Autowired
	TransactionRepository transactionRepo;
	
	@Autowired
	ItemRepository itemRepo;
	
	@Autowired
	BudgetRepository budgetRepo;
	
	public User registerUser(User user) {
		String hashed = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
		user.setPassword(hashed);
		return userRepo.save(user);
	}
	
	public boolean authenticateUser(String email, String password) {
		User user = userRepo.findByEmail(email);
		if(user == null) {
			return false;
		} else if(BCrypt.checkpw(password, user.getPassword())){
			return true;
		} else {
			return false;
		}
	}
	
	public User findByEmail(String email) {
		return userRepo.findByEmail(email);
	}
	
	public User findById(Long id) {
		Optional<User> u = userRepo.findById(id);
		if(u.isPresent()) {
			return u.get();
		} else {
			return null;
		}
	}
	
	public List<Category> findAll(){
		return categoryRepo.findAll();
	}
	
	public Category findCategoryById(Long id) {
		Optional<Category> c = categoryRepo.findById(id);
		if(c.isPresent()) {
			return c.get();
		} else {
			return null;
		}
	}
	
	public List<Transaction> findAllTransactions(){
		return transactionRepo.findAll();
	}
	
	public List<Item> findAllItems(){
		return itemRepo.findAll();
	}
	
	public List<Item> findItemsByCategory(Long id){
		return itemRepo.findItemsByCategoryId(id);
	}
	
	public Item findItemsById(Long id) {
		Optional<Item> i = itemRepo.findById(id);
		if(i.isPresent()) {
			return i.get();
		} else {
			return null;
		}
	}
	
	public Budget findBudgetById(Long id) {
		Optional<Budget> b = budgetRepo.findById(id);
		if(b.isPresent()) {
			return b.get();
		} else {
			return null;
		}
	}
	
	
	
	public Item newItem(Item item) {
		return itemRepo.save(item);
	}
	
	
	public User addUser(User user) {
		return userRepo.save(user);
	}
	
	public Category newCategory(Category category) {
		return categoryRepo.save(category);
	}
	
	public Category updateCategory(Category category) {
		return categoryRepo.save(category);
	}
	
	public Transaction newTransaction(Transaction transaction) {
		return transactionRepo.save(transaction);
	}
	
	public Budget newBudget(Budget budget) {
		return budgetRepo.save(budget);
	}
	
}
