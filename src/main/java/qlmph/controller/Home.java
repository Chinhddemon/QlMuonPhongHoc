package qlmph.controller;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class Home {

    @Autowired
    private ServletContext servletContext;

    @RequestMapping("/HomeRegular")
    public String showScreenManager(Model model,
            RedirectAttributes redirectAttributes) {

        model.addAttribute("addressContact", "97 Đ. Man Thiện, Hiệp Phú, Thủ Đức, TP. Hồ Chí Minh");
        model.addAttribute("emailContact", "pctsv@ptithcm.edu.vn");
        model.addAttribute("phoneContact", "028.389 666 75");

        if (!model.containsAttribute("UIDRegular")) {
            redirectAttributes.addFlashAttribute("Message", "Hãy đảm bảo giữ kết nối và truy cập lại trang web.");
            return "redirect:/Login?Command=Logout";
        }
        return "home/home-regular";
    }

    @RequestMapping("/HomeManager")
    public String showScreenRegular(Model model) {

        model.addAttribute("addressContact", "97 Đ. Man Thiện, Hiệp Phú, Thủ Đức, TP. Hồ Chí Minh");
        model.addAttribute("emailContact", "pctsv@ptithcm.edu.vn");
        model.addAttribute("phoneContact", "028.389 666 75");

        if (model.containsAttribute("UIDManager") || servletContext.getAttribute("UIDManager") != null) {
            model.addAttribute("Token", servletContext.getAttribute("token"));
            return "home/home-manager";
        } else if (model.containsAttribute("UIDAdmin") || servletContext.getAttribute("UIDAdmin") != null) {
            model.addAttribute("TokenAdmin", servletContext.getAttribute("tokenAdmin"));
            return "home/home-manager";
        }

        return "redirect:/Login";
    }

}
