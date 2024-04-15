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
import qlmph.utils.ValidateObject;

@Controller
public class Login {

    @Autowired
    private ServletContext servletContext;

    @Autowired
    TaiKhoanService taiKhoanService;

    @RequestMapping("/Login")
    public String showLoginScreen(
            @RequestParam(value = "Message", required = false) String message,
            @RequestParam(value = "Command", defaultValue = "Login") String command,
            @RequestParam(value = "uuid", required = false) String uid,
            RedirectAttributes redirectAttributes,
            Model model) {

        if (ValidateObject.isNullOrEmpty(uid)) {
            model.addAttribute("errorMessage", message);
            return "login";
        }

        TaiKhoan taiKhoan = taiKhoanService.layThongTin(uid);
        if (ValidateObject.isNullOrEmpty(taiKhoan)) {
            model.addAttribute("errorMessage", message);
            return "login";
        }

        String vaiTro = taiKhoan.getVaiTro().getMaVaiTro();
        if (ValidateObject.isNullOrEmpty(vaiTro)) {
            model.addAttribute("errorMessage", message);
            return "login";
        }

        switch (command) {
            case "Home":
                if (vaiTro.equals("User")) {
                    redirectAttributes.addFlashAttribute("UIDRegular", uid);
                    return "redirect:/HomeRegular.htm";

                } else if (vaiTro.equals("Manager")) {
                    redirectAttributes.addFlashAttribute("UIDManager", uid);
                    return "redirect:/HomeManager.htm";

                } else if (vaiTro.equals("Admin")) {
                    redirectAttributes.addFlashAttribute("UIDAdmin", uid);
                    return "redirect:/HomeManager.htm";

                }
                model.addAttribute("errorMessage", message);
                return "login";

            case "Logout":
                if (vaiTro.equals("User")) {
                    return "login";

                } else if (vaiTro.equals("Manager")) {
                    servletContext.removeAttribute("token");
                    servletContext.removeAttribute("UIDManager");

                } else if (vaiTro.equals("Admin")) {
                    servletContext.removeAttribute("tokenAdmin");
                    servletContext.removeAttribute("UIDAdmin");

                }
                model.addAttribute("errorMessage", message);
                return "login";

            default:
                model.addAttribute("errorMessage", message);
                return "login";
        }
    }

    @RequestMapping(value = "/Login", method = RequestMethod.POST)
    public String processLogin(@ModelAttribute TaiKhoan taiKhoan,
            Model model,
            RedirectAttributes redirectAttributes) {
        taiKhoan = taiKhoanService.dangNhap(taiKhoan.getTenDangNhap(), taiKhoan.getMatKhau());
        if (ValidateObject.isNullOrEmpty(taiKhoan)) {
            model.addAttribute("errorMessage", "Tài khoản hoặc mật khẩu không đúng, hãy thử lại.");
            return "login";
        }

        String uid = taiKhoan.getIdTaiKhoan().toString();
        String vaiTro = taiKhoan.getVaiTro().getMaVaiTro();
        if (ValidateObject.isNullOrEmpty(vaiTro)
                || ValidateObject.isNullOrEmpty(uid)) {
            model.addAttribute("errorMessage", "Tài khoản hoặc mật khẩu không đúng, hãy thử lại.");
            return "login";
        }

        switch (vaiTro) {
            case "User":
                if (ValidateObject.isNullOrEmpty(servletContext.getAttribute("UIDManager"))) {
                    model.addAttribute("errorMessage", "Quản lý chưa đăng nhập, vui lòng liên hệ pctsv để hỗ trợ.");
                    return "login";

                }
                redirectAttributes.addFlashAttribute("UIDRegular", uid);
                return "redirect:/HomeRegular.htm";

            case "Manager":
                String UIDManager = (String) servletContext.getAttribute("UIDManager");

                if (ValidateObject.isNullOrEmpty(UIDManager)) {
                    servletContext.setAttribute("token", Token.createRandom());
                    servletContext.setAttribute("UIDManager", uid);
                    redirectAttributes.addFlashAttribute("UIDManager", uid);
                    return "redirect:/HomeManager.htm";

                } else if (UIDManager.equals(uid)) {
                    redirectAttributes.addFlashAttribute("UIDManager", uid);
                    return "redirect:/HomeManager.htm";

                }
                model.addAttribute("errorMessage", "Quản lý khác đã đăng nhập ứng dụng.");
                return "login";

            case "Admin":
                String UIDAdmin = (String) servletContext.getAttribute("UIDAdmin");

                if (ValidateObject.isNullOrEmpty(UIDAdmin)) {
                    servletContext.setAttribute("tokenAdmin", Token.createRandom());
                    servletContext.setAttribute("UIDAdmin", uid);
                    redirectAttributes.addFlashAttribute("UIDAdmin", uid);
                    return "redirect:/HomeManager.htm";

                } else if (UIDAdmin.equals(uid)) {
                    redirectAttributes.addFlashAttribute("UIDAdmin", uid);
                    return "redirect:/HomeManager.htm";

                }
                model.addAttribute("errorMessage", "Quản trị viên khác đã đăng nhập ứng dụng.");
                return "login";

            default:
                model.addAttribute("errorMessage", "Tài khoản hoặc mật khẩu không đúng, hãy thử lại.");
                return "login";
        }
    }
}