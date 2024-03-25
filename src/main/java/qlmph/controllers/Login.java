package qlmph.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import qlmph.models.QLTaiKhoan.TaiKhoan;
import qlmph.services.TaiKhoanService;
import qlmph.services.VaiTroService;

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
    public String processLogin(@ModelAttribute TaiKhoan taiKhoan,
                                Model model, 
                                RedirectAttributes redirectAttributes) {

        taiKhoan = TaiKhoanService.getByTenDangNhapAndMatKhau(taiKhoan.getTenDangNhap(), taiKhoan.getMatKhau());
        String uid = TaiKhoanService.getUID(taiKhoan);
        String vaiTro = VaiTroService.checkVaiTroInTaiKhoan(taiKhoan);
        
        if(vaiTro.equals("Regular")) redirectAttributes.addFlashAttribute("UIDRegular", uid);

        else if(vaiTro.equals("Manager")) redirectAttributes.addFlashAttribute("UIDManager", uid);

        else if(vaiTro.equals("Admin")) redirectAttributes.addFlashAttribute("UIDAdmin", uid);

        else {
            model.addAttribute("errorMessage", "Tài khoản hoặc mật khẩu không đúng, hãy thử lại.");
            return "login";
        }

        return "redirect:/Home";
    } 

}