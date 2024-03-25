package qlmph.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/Home")
public class Home {

	@RequestMapping()
	public String showScreen(Model model) {

		// model.addAttribute("UIDManager", "123456");
//		model.addAttribute("UIDRegular", "123456");

		return "home/home-manager";
	}
	
}
