package qlmph.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import qlmph.models.QLTaiKhoan.TaiKhoan;

@Controller
public class Login {
	
	@RequestMapping("/Login")
    public String showLoginScreen(
    		@RequestParam ("Message") String Message,
    		Model model) {
        model.addAttribute("errorMessage", Message);
        return "login";
    }

    @RequestMapping(value = "/Login", method = RequestMethod.POST)
    public String processLogin(@ModelAttribute TaiKhoan user) {
        /*  
        if ( TaiKhoanService.isManager(user) ) {
            return "home/home-manager";
        }
        else if ( TaiKhoanService.isRegular(user) ) {
            return "home/home-regular";
        }
        else {
            return "redirect:/Error";
        }
        */
        
        // Developer line 
        return "home/home-manager";
    }

}