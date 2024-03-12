package cnpm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/home")
public class Home {
	
	@RequestMapping("")
	public String showLoginForm() {
		return "/home";
	}	
	
}