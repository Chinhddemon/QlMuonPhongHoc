package qlmph.controllers.manager;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/DsNgMPH")
public class DsNgMuonPhong {
    
    @RequestMapping("/DsNgMPH")
    public String showLoginForm() {
        // Yêu cầu: 
            // setAttribute UIDManager để truy cập trang
            // thay đổi nội dung phần javascript trong đường dẫn
        return "/home/HomeManager";
    }

}