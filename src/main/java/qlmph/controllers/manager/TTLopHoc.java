package qlmph.controllers.manager;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import qlmph.bean.TTLopHocBean;
import qlmph.services.TTLopHocService;

@Controller
@RequestMapping("/TTLH")
public class TTLopHoc {
    
    @RequestMapping("XemTTLH")
    public String showLoginForm(
    		@RequestParam ("MaLH") String MaLH,
    		Model model) {
    	TTLopHocBean tTLopHoc = TTLopHocService.getByMaLH(MaLH);
    	model.addAttribute("TTlopHoc", tTLopHoc);
        // Yêu cầu: 
            // setAttribute UIDRegular để truy cập trang
            // thay đổi nội dung phần javascript trong đường dẫn
        return "/home/HomeManager";
    }

    @RequestMapping("SuaTTLH")
    public String showLoginForm() {
        // Yêu cầu: 
            // setAttribute UIDRegular để truy cập trang
            // thay đổi nội dung phần javascript trong đường dẫn
        return "/home/HomeManager";
    }
}
