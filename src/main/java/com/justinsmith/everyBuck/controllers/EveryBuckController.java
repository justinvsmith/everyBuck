package com.justinsmith.everyBuck.controllers;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.justinsmith.everyBuck.models.Budget;
import com.justinsmith.everyBuck.models.Category;
import com.justinsmith.everyBuck.models.Item;
import com.justinsmith.everyBuck.models.Transaction;
import com.justinsmith.everyBuck.models.User;
import com.justinsmith.everyBuck.services.EveryBuckService;
import com.justinsmith.everyBuck.validator.UserValidator;

@Controller
public class EveryBuckController {
	private final EveryBuckService userService;
	private final EveryBuckService categoryService;
	private final EveryBuckService transactionService;
	private final EveryBuckService itemService;
	private final EveryBuckService budgetService;
	private final UserValidator userValidator;
	
	public Date date;
	
	
	public EveryBuckController(EveryBuckService userService, EveryBuckService categoryService, EveryBuckService transactionService, EveryBuckService itemService, EveryBuckService budgetService, UserValidator userValidator) {
		this.userService = userService;
		this.categoryService = categoryService;
		this.transactionService = transactionService;
		this.itemService = itemService;
		this.budgetService = budgetService;
		this.userValidator = userValidator;
	}
	
	@RequestMapping("/")
	public String index(@ModelAttribute("user") User user) {
		return "login.jsp";
	}
	
	@RequestMapping(value="/registration", method=RequestMethod.POST)
    public String registerUser(@Valid @ModelAttribute("user") User user, BindingResult result, HttpSession session) {
    	userValidator.validate(user, result);
    	if(result.hasErrors()) {
    		return "login.jsp";
    	} else {
    		User u = userService.registerUser(user);
    		session.setAttribute("userid", u.getId());
    		return "redirect:/dashboard";
    	}

    }
	
	@RequestMapping(value="/login", method=RequestMethod.POST)
    public String loginUser(@ModelAttribute("user")User user, @RequestParam("email") String email, @RequestParam("password") String password, Model model, HttpSession session) {
        boolean isAuthenticated = userService.authenticateUser(email, password);
        if(isAuthenticated) {
        	User u = userService.findByEmail(email);
        	session.setAttribute("userid", u.getId());
        	return "redirect:/dashboard";
        } else {
        	String error = "Invalid Credentials, please try again.";
        	model.addAttribute("error", error );
        	return "login.jsp";
        }
    	
    	
    }
	
	@RequestMapping("/dashboard")
	public String dashboard(@ModelAttribute("category") Category category, @ModelAttribute("item") Item item,
							@ModelAttribute("transaction") Transaction transaction, @ModelAttribute("budget") Budget budget, Long id,
							HttpSession session, Model model) {
		Long uid = (Long)session.getAttribute("userid");
		User user = userService.findById(uid);
		model.addAttribute("activeU", user);
		List<Category> c = categoryService.findAll();
		model.addAttribute("categories", c);
		List<Transaction> t = transactionService.findAllTransactions();
		model.addAttribute("transactions", t);
		List<Item> i = itemService.findAllItems();
		model.addAttribute("items", i);
		SimpleDateFormat formatted = new SimpleDateFormat("MMMM");  
		Date d = new Date();
		String month = formatted.format(d);
		model.addAttribute("month", month);
		SimpleDateFormat format = new SimpleDateFormat("yyyy");
		Date da = new Date();
		String year = format.format(da);
		model.addAttribute("year", year);
		return "index.jsp";
	}
	
	@RequestMapping(value="/newCategory", method=RequestMethod.POST)
	public String newCategory(@Valid @ModelAttribute("category") Category category, BindingResult result, HttpSession session){
		Long uid = (Long)session.getAttribute("userid");
		User user = userService.findById(uid);	
		if(result.hasErrors()) {
			return "index.jsp";
		} else {
			Category j = categoryService.newCategory(category);
			Long id = j.getId();
			Category newC = categoryService.findCategoryById(id);
			user.getCategories().add(newC);
			categoryService.addUser(user);
			return "redirect:/dashboard";
		}
	}
	
	@RequestMapping("/newItem")
	public String itemIndex(@ModelAttribute("item") Item item, @ModelAttribute("category") Category category, Model model) {
		List<Category> categoryA = categoryService.findAll();
		model.addAttribute("categories", categoryA);
		return "newItem.jsp";
	}
	
	@RequestMapping(value="/newItem", method=RequestMethod.POST)
	public String newItem(@Valid @ModelAttribute("item") Item item, BindingResult result) {
		if(result.hasErrors()) {
			return "index.jsp";
		} else {
			itemService.newItem(item);
			return "redirect:/dashboard";
		}
	}
	
	@RequestMapping("/newTransaction")
	public String transactionsIndex(@ModelAttribute("transaction")Transaction transaction, Model model) {
		List<Item> items = itemService.findAllItems();
		model.addAttribute("items", items);
		return "newTransaction.jsp";
	}
	
	@RequestMapping(value="/newTransaction", method=RequestMethod.POST)
	public String newTransaction(@Valid @ModelAttribute("transaction") Transaction transaction, BindingResult result) {
		if(result.hasErrors()) {
			return "index.jsp";
		} else {
			transactionService.newTransaction(transaction);
			return "redirect:/dashboard";
		}
	}
	
	@RequestMapping("/newBudget")
	public String budgetIndex(@ModelAttribute("budget") Budget budget, Model model){
		return "newBudget.jsp";
	}
	
	@RequestMapping(value="/newBudget", method=RequestMethod.POST)
	public String newBudget(@Valid @ModelAttribute("budget") Budget budget, BindingResult result) {
		if(result.hasErrors()) {
			return "index.jsp";
		} else {
			budgetService.newBudget(budget);
			return "redirect:/dashboard";
		}
	}
}
