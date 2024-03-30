package qlmph.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class Home {

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
			return "home/home-manager";
	    }
		else if (model.containsAttribute("UIDAdmin")) {
			return "home/home-manager";
	    }

		return "redirect:/Login.htm";
	}
	
}
