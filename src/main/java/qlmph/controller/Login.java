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

    @RequestMapping("/LoginRegular") // MARK: - LoginRegular
    public String showLoginRegularScreen(
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
        if (ValidateObject.isNullOrEmpty(taiKhoan) || ValidateObject.isNullOrEmpty(taiKhoan.getVaiTros())) {
            model.addAttribute("errorMessage", message);
            return "login";
        }

        if(vaiTroService.vaiTroLaKhachHang(taiKhoan.getVaiTros()) ) {
            switch (command) {
                case "Home":
                    redirectAttributes.addFlashAttribute("UIDRegular", uid);
                    return "redirect:/HomeRegular";
                case "Logout":
                    break;
            }
        }

        model.addAttribute("errorMessage", message);
        return "login";
    }

    @RequestMapping(value = "/LoginRegular", method = RequestMethod.POST)
    public String processLoginRegular(Model model,
            RedirectAttributes redirectAttributes,
            @ModelAttribute TaiKhoan taiKhoan) {
        taiKhoan = taiKhoanService.dangNhapKhachHang(taiKhoan.getTenDangNhap(), taiKhoan.getMatKhau());
        if (ValidateObject.isNullOrEmpty(taiKhoan) || ValidateObject.isNullOrEmpty(taiKhoan.getVaiTros())) {
            model.addAttribute("errorMessage", "Tài khoản hoặc mật khẩu không đúng, hãy thử lại.");
            return "login";
        }

        if (ValidateObject.isNullOrEmpty(servletContext.getAttribute("UIDManager"))) {
            model.addAttribute("errorMessage", "Quản lý chưa đăng nhập, vui lòng liên hệ pctsv để hỗ trợ.");
            return "login";

        }
        redirectAttributes.addFlashAttribute("UIDRegular", taiKhoan.getIdTaiKhoan().toString());
        return "redirect:/HomeRegular";
    }

    @RequestMapping("/LoginManager") // MARK: - LoginManager
    public String showLoginManagerScreen(
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

        TaiKhoan taiKhoan = taiKhoanService.layThongTinQuanLy(uid);
        if (ValidateObject.isNullOrEmpty(taiKhoan) || ValidateObject.isNullOrEmpty(taiKhoan.getVaiTros())) {
            model.addAttribute("errorMessage", message);
            return "login";
        }

        if(vaiTroService.vaiTroLaQuanLy(taiKhoan.getVaiTros()) ) {
            switch (command) {
                case "Home":
                    redirectAttributes.addFlashAttribute("UIDManager", uid);
                    return "redirect:/HomeManager";
                case "Logout":
                    servletContext.removeAttribute("OTP");
                    servletContext.removeAttribute("UIDManager");
            }
        }
        model.addAttribute("errorMessage", message);
        return "login";
    }

    @RequestMapping(value = "/LoginManager", method = RequestMethod.POST)
    public String processLoginManager(Model model,
            RedirectAttributes redirectAttributes,
            @ModelAttribute TaiKhoan taiKhoan) {
        taiKhoan = taiKhoanService.dangNhapQuanLy(taiKhoan.getTenDangNhap(), taiKhoan.getMatKhau());
        if (ValidateObject.isNullOrEmpty(taiKhoan) || ValidateObject.isNullOrEmpty(taiKhoan.getVaiTros())) {
            model.addAttribute("errorMessage", "Tài khoản hoặc mật khẩu không đúng, hãy thử lại.");
            return "login";
        }

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

    @RequestMapping("/LoginAdmin") // MARK: - LoginAdmin
    public String showLoginAdminScreen(
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

        TaiKhoan taiKhoan = taiKhoanService.layThongTinQuanTriVien(uid);
        if (ValidateObject.isNullOrEmpty(taiKhoan) || ValidateObject.isNullOrEmpty(taiKhoan.getVaiTros())) {
            model.addAttribute("errorMessage", message);
            return "login";
        }
        
        if(vaiTroService.vaiTroLaQuanTriVien(taiKhoan.getVaiTros()) ) {
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

    @RequestMapping(value = "/LoginAdmin", method = RequestMethod.POST)
    public String processLoginAdmin(Model model,
            RedirectAttributes redirectAttributes,
            @ModelAttribute TaiKhoan taiKhoan) {
        taiKhoan = taiKhoanService.dangNhapQuanTriVien(taiKhoan.getTenDangNhap(), taiKhoan.getMatKhau());
        if (ValidateObject.isNullOrEmpty(taiKhoan) || ValidateObject.isNullOrEmpty(taiKhoan.getVaiTros())) {
            model.addAttribute("errorMessage", "Tài khoản hoặc mật khẩu không đúng, hãy thử lại.");
            return "login";
        }

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
}