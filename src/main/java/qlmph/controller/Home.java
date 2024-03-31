package qlmph.controller;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class Home {

	@Autowired
    private ServletContext servletContext;

	@RequestMapping("/HomeRegular")
	public String showScreenManager(Model model) {

		if (model.containsAttribute("UIDRegular")) {
	        return "home/home-regular";
	    }
		
		return "redirect:/Login.htm";
	}
	
	@RequestMapping("/HomeManager")
	public String showScreenRegular(Model model) {

		if (model.containsAttribute("UIDManager")) {
			model.addAttribute("Token", servletContext.getAttribute("token"));
			return "home/home-manager";
	    }
		else if (model.containsAttribute("UIDAdmin")) {
			model.addAttribute("TokenAdmin", servletContext.getAttribute("tokenAdmin"));
			return "home/home-manager";
	    }

		return "redirect:/Login.htm";
	}
	
}
