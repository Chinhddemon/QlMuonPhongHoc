package qlmph.controller;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import qlmph.model.user.TaiKhoan;
import qlmph.service.user.NguoiDungService;
import qlmph.service.user.TaiKhoanService;
import qlmph.service.user.VaiTroService;
import qlmph.utils.Token;
import qlmph.utils.ValidateObject;

@Controller
public class Login {

    @Autowired
    private ServletContext servletContext;

    @Autowired
    NguoiDungService nguoiDungService;

    @Autowired
    TaiKhoanService taiKhoanService;

    @Autowired
    VaiTroService vaiTroService;

    @RequestMapping("/Login") // MARK: - LoginRegular
    public String showLoginScreen(
            @RequestParam(value = "Message", required = false) String message,
            @RequestParam(value = "Command", defaultValue = "Login") String command,
            @RequestParam(value = "uuid", required = false) String uid,
            RedirectAttributes redirectAttributes,
            Model model) {

        model.addAttribute("addressContact", "97 Đ. Man Thiện, Hiệp Phú, Thủ Đức, TP. Hồ Chí Minh");
        model.addAttribute("emailContact", "pctsv@ptithcm.edu.vn");
        model.addAttribute("phoneContact", "028.389 666 75");

        if (ValidateObject.isNullOrEmpty(uid)) {
            model.addAttribute("errorMessage", message);
            return "login";
        }

        TaiKhoan taiKhoan = taiKhoanService.layThongTinKhachHang(uid);
        if (ValidateObject.isNotNullOrEmpty(taiKhoan) && ValidateObject.isNotNullOrEmpty(taiKhoan.getVaiTros())) {
            switch (command) {
                case "Home":
                    redirectAttributes.addFlashAttribute("UIDRegular", uid);
                    return "redirect:/HomeRegular";
                case "Logout":
                    break;
            }
        }
        TaiKhoan taiKhoan2 = taiKhoanService.layThongTinQuanLy(uid);
        if (ValidateObject.isNotNullOrEmpty(taiKhoan2) && ValidateObject.isNotNullOrEmpty(taiKhoan2.getVaiTros())) {
            switch (command) {
                case "Home":
                    redirectAttributes.addFlashAttribute("UIDManager", uid);
                    return "redirect:/HomeManager";
                case "Logout":
                    servletContext.removeAttribute("OTP");
                    servletContext.removeAttribute("UIDManager");
            }
        }
        TaiKhoan taiKhoan3 = taiKhoanService.layThongTinQuanTriVien(uid);
        if (ValidateObject.isNotNullOrEmpty(taiKhoan3) && ValidateObject.isNotNullOrEmpty(taiKhoan3.getVaiTros())) {
            switch (command) {
                case "Home":
                    redirectAttributes.addFlashAttribute("UIDAdmin", uid);
                    return "redirect:/HomeAdmin";
                case "Logout":
                    servletContext.removeAttribute("OTPAdmin");
                    servletContext.removeAttribute("UIDAdmin");
            }
        }

        model.addAttribute("errorMessage", message);
        return "login";
    }

    @RequestMapping(value = "/Login", method = RequestMethod.POST)
    public String processLogin(Model model,
            RedirectAttributes redirectAttributes,
            @RequestParam("tenDangNhap") String tenDangNhap,
            @RequestParam("matKhau") String matKhau) {
        TaiKhoan taiKhoan = null;
        taiKhoan = taiKhoanService.dangNhapKhachHang(tenDangNhap, matKhau);
        if (ValidateObject.isNotNullOrEmpty(taiKhoan) && ValidateObject.isNotNullOrEmpty(taiKhoan.getVaiTros())) {
            if (ValidateObject.isNullOrEmpty(servletContext.getAttribute("UIDManager"))) {
                model.addAttribute("errorMessage", "Quản lý chưa đăng nhập, vui lòng liên hệ pctsv để hỗ trợ.");
                return "login";
            }
            redirectAttributes.addFlashAttribute("UIDRegular", taiKhoan.getIdTaiKhoan().toString());
            return "redirect:/HomeRegular";
        }
        
        taiKhoan = taiKhoanService.dangNhapQuanLy(tenDangNhap, matKhau);
        if (ValidateObject.isNotNullOrEmpty(taiKhoan) && ValidateObject.isNotNullOrEmpty(taiKhoan.getVaiTros())) {
            String UIDManager = (String) servletContext.getAttribute("UIDManager");

            if (ValidateObject.isNullOrEmpty(UIDManager)) {
                servletContext.setAttribute("OTP", Token.createRandom());
                servletContext.setAttribute("UIDManager", taiKhoan.getIdTaiKhoan().toString());
                redirectAttributes.addFlashAttribute("UIDManager", taiKhoan.getIdTaiKhoan().toString());
                return "redirect:/HomeManager";
            } else if (UIDManager.equals(taiKhoan.getIdTaiKhoan().toString())) {
                redirectAttributes.addFlashAttribute("UIDManager", taiKhoan.getIdTaiKhoan().toString());
                return "redirect:/HomeManager";
            }
            model.addAttribute("errorMessage", "Quản lý khác đã đăng nhập ứng dụng.");
            return "login";
        }
        
        taiKhoan = taiKhoanService.dangNhapQuanTriVien(tenDangNhap, matKhau);
        if (ValidateObject.isNotNullOrEmpty(taiKhoan) && ValidateObject.isNotNullOrEmpty(taiKhoan.getVaiTros())) {
            String UIDAdmin = (String) servletContext.getAttribute("UIDAdmin");

            if (ValidateObject.isNullOrEmpty(UIDAdmin)) {
                servletContext.setAttribute("OTPAdmin", Token.createRandom());
                servletContext.setAttribute("UIDAdmin", taiKhoan.getIdTaiKhoan().toString());
                redirectAttributes.addFlashAttribute("UIDAdmin", taiKhoan.getIdTaiKhoan().toString());
                return "redirect:/HomeAdmin";
            } else if (UIDAdmin.equals(taiKhoan.getIdTaiKhoan().toString())) {
                redirectAttributes.addFlashAttribute("UIDAdmin", taiKhoan.getIdTaiKhoan().toString());
                return "redirect:/HomeAdmin";
            }
            model.addAttribute("errorMessage", "Quản trị viên khác đã đăng nhập ứng dụng.");
            return "login";
        }

        model.addAttribute("errorMessage", "Tài khoản hoặc mật khẩu không đúng, hãy thử lại.");
        return "login";
    }
}