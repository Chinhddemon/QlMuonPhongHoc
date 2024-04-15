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

        if (!model.containsAttribute("UIDRegular")) {
            return "redirect:/Login.htm?Command=Logout&Message=Hãy đảm bảo giữ kết nối và truy cập lại trang web.";
        }
        return "home/home-regular";
    }

    @RequestMapping("/HomeManager")
    public String showScreenRegular(Model model) {

        if (model.containsAttribute("UIDManager") || servletContext.getAttribute("UIDManager") != null) {
            model.addAttribute("Token", servletContext.getAttribute("token"));
            return "home/home-manager";
        } else if (model.containsAttribute("UIDAdmin") || servletContext.getAttribute("UIDAdmin") != null) {
            model.addAttribute("TokenAdmin", servletContext.getAttribute("tokenAdmin"));
            return "home/home-manager";
        }

        return "redirect:/Login.htm";
    }

}
