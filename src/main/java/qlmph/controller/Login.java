package qlmph.controller;

import javax.servlet.ServletContext;

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
import qlmph.utils.Token;

@Controller
public class Login {

	@Autowired
    private ServletContext servletContext;

    @Autowired
    TaiKhoanService taiKhoanService;
	
	@RequestMapping("/Login")
    public String showLoginScreen(
    		@RequestParam (value = "Message", required = false) String Message,
			@RequestParam (value = "Command", defaultValue = "Login") String Command,
    		@RequestParam(value = "uuid", required = false) String uid,
    		RedirectAttributes redirectAttributes,
    		Model model) {
		if(uid != null && !uid.equals("")) {
			if(Command.equals("Home")) {
				TaiKhoan taiKhoan = taiKhoanService.xemThongTin(uid);
				if (taiKhoan != null) {
					String vaiTro = taiKhoan.getVaiTro().getTenVaiTro();
					if( vaiTro != null) {
						if(vaiTro.equals("Người mượn phòng")) { 
							redirectAttributes.addFlashAttribute("UIDRegular", uid);
							return "redirect:/HomeRegular.htm";
						} else if(vaiTro.equals("Quản lý")) { 
							redirectAttributes.addFlashAttribute("UIDManager", uid);
							return "redirect:/HomeManager.htm";
						} else if(vaiTro.equals("Admin")) { 
							redirectAttributes.addFlashAttribute("UIDAdmin", uid);
							return "redirect:/HomeManager.htm";
						}
					}
				}  
			}
			else if(Command.equals("Logout")) {
				TaiKhoan taiKhoan = taiKhoanService.xemThongTin(uid);
				if (taiKhoan != null) {
					String vaiTro = taiKhoan.getVaiTro().getTenVaiTro();
					if( vaiTro != null) {
						if(vaiTro.equals("Người mượn phòng")) { 
							return "login";
						} else if(vaiTro.equals("Quản lý")) { 
							servletContext.removeAttribute("token");
						} else if(vaiTro.equals("Admin")) { 
							servletContext.removeAttribute("tokenAdmin");
						}
						return "login";
					}
				}  
				servletContext.removeAttribute("token");
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
		if (taiKhoan == null) {
			model.addAttribute("errorMessage", "Tài khoản hoặc mật khẩu không đúng, hãy thử lại.");
			return "login";
		}

		String uid = taiKhoan.getIdTaiKhoan().toString();
		String vaiTro = taiKhoan.getVaiTro().getTenVaiTro();
		if (vaiTro == null || uid == null) {
			model.addAttribute("errorMessage", "Tài khoản hoặc mật khẩu không đúng, hãy thử lại.");
			return "login";
		}

		switch (vaiTro) {
			case "Người mượn phòng":
				redirectAttributes.addFlashAttribute("UIDRegular", uid);
				return "redirect:/HomeRegular.htm";
			case "Quản lý":
				String UIDManager = (String) servletContext.getAttribute("UIDManager");
				if (UIDManager != null && !UIDManager.equals("")) {
					if (!UIDManager.equals(uid)) {
						model.addAttribute("errorMessage", "Quản lý khác đã đăng nhập ứng dụng.");
						return "login";
					}
				} else {
					servletContext.setAttribute("token", Token.createRandom());
					servletContext.setAttribute("UIDManager", uid);
				}
				redirectAttributes.addFlashAttribute("UIDManager", uid);
				return "redirect:/HomeManager.htm";
			case "Admin":
				String UIDAdmin = (String) servletContext.getAttribute("UIDAdmin");
				if (UIDAdmin != null && !UIDAdmin.equals("")) {
					model.addAttribute("errorMessage", "Quản trị viên khác đã đăng nhập ứng dụng.");
					return "login";
				} else {
					servletContext.setAttribute("UIDAdmin", uid);
					servletContext.setAttribute("tokenAdmin", Token.createRandom());
				}
				redirectAttributes.addFlashAttribute("UIDAdmin", uid);
				return "redirect:/HomeManager.htm";
			default:
				model.addAttribute("errorMessage", "Tài khoản hoặc mật khẩu không đúng, hãy thử lại.");
				return "login";
		}      
    } 
}