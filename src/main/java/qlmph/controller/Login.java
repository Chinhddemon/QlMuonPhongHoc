package qlmph.controller;

import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import qlmph.model.QLTaiKhoan.TaiKhoan;
import qlmph.service.TaiKhoanService;

@Controller
public class Login {
    @Autowired
    TaiKhoanService taiKhoanService;
	
	
	@RequestMapping("/Login")
    public String showLoginScreen(
    		@RequestParam (value = "Message", required = false) String Message,
    		@RequestParam(value = "uuid", required = false) String uuid,
    		RedirectAttributes redirectAttributes,
    		Model model) {
		if(uuid != null) {
			TaiKhoan taiKhoan = taiKhoanService.xemThongTin(UUID.fromString(uuid));
			if (taiKhoan != null) {
	            String vaiTro = taiKhoan.getVaiTro().getTenVaiTro();
	            if( vaiTro != null) {
	                if(vaiTro.equals("Người mượn phòng")) { 
	                	redirectAttributes.addFlashAttribute("UIDRegular", uuid);
	                	return "redirect:/HomeRegular.htm";
	                }

	                else if(vaiTro.equals("Quản lý")) { 
	                	redirectAttributes.addFlashAttribute("UIDManager", uuid);
	                	return "redirect:/HomeManager.htm";
	                }

	                else if(vaiTro.equals("Admin")) { 
	                	redirectAttributes.addFlashAttribute("UIDAdmin", uuid);
	                	return "redirect:/HomeManager.htm";
	                }
	                
	            }
	        }   
		}
        model.addAttribute("errorMessage", Message);
        return "login";
    }

    @RequestMapping(value = "/Login", method = RequestMethod.POST)
    public String processLogin(@ModelAttribute TaiKhoan taiKhoan,
                                Model model, 
                                RedirectAttributes redirectAttributes) {

        taiKhoan = taiKhoanService.dangNhap(taiKhoan.getTenDangNhap(), taiKhoan.getMatKhau());
        if (taiKhoan != null) {
            String uid = taiKhoan.getIdTaiKhoan().toString();
            String vaiTro = taiKhoan.getVaiTro().getTenVaiTro();
            if( vaiTro != null && uid != null) {
                if(vaiTro.equals("Người mượn phòng")) { 
                	redirectAttributes.addFlashAttribute("UIDRegular", uid);
                	return "redirect:/HomeRegular.htm";
                }

                else if(vaiTro.equals("Quản lý")) { 
                	redirectAttributes.addFlashAttribute("UIDManager", uid);
                	return "redirect:/HomeManager.htm";
                }

                else if(vaiTro.equals("Admin")) { 
                	redirectAttributes.addFlashAttribute("UIDAdmin", uid);
                	return "redirect:/HomeManager.htm";
                }
                
            }
        }                  
        
        model.addAttribute("errorMessage", "Tài khoản hoặc mật khẩu không đúng, hãy thử lại.");
        return "login";
    } 

}