package qlmph.controllers.manager;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/TTLH")
public class TTLopHoc {
    
    @RequestMapping("XemTTLH")
    public String showLoginForm() {
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
