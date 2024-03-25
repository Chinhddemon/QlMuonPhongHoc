package qlmph.controllers;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import qlmph.models.QLTaiKhoan.TaiKhoan;
import qlmph.services.TaiKhoanService;

@Controller
public class LoginController {
	TaiKhoanService taiKhoanService = new TaiKhoanService();

	@RequestMapping("/login")
	public String showLoginScreen() {
		return "loginScreen";
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String processLogin(@ModelAttribute TaiKhoan user, ModelMap model, RedirectAttributes redirectAttributes) {
		int id = 0;
		if (taiKhoanService.kiemTraDangNhap(user.getTenDangNhap(), user.getMatKhau())) {
			id = taiKhoanService.layIdTuTDN(user.getTenDangNhap());
			System.out.print(id);
			if (id > 0) {
				if (taiKhoanService.isManager(user.getTenDangNhap())) {
					id = taiKhoanService.layIdTuTDN(user.getTenDangNhap());
					redirectAttributes.addFlashAttribute("UIDManager", id);
				} else {
					redirectAttributes.addFlashAttribute("UIDRegular", id);
				}
				return "redirect:/home.htm";
			} else {
				model.addAttribute("errorMessage", "Có lỗi xảy ra vui lòng đăng nhập lại");
				return "loginScreen";
			}
		} else {
			model.addAttribute("errorMessage", "Tài khoản hoặc mật khẩu không hợp lệ");
			return "loginScreen";
		}
	}

	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpServletRequest request) {
		return "redirect:/login.htm";
	}
}
