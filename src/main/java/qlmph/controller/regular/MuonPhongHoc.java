package qlmph.controller.regular;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/MPH")
public class MuonPhongHoc {
    
    @RequestMapping("/ChonLMPH")
    public String showDsMPH() {
        // Yêu cầu: 
            // setAttribute UIDRegular để truy cập trang
            // thay đổi nội dung phần javascript trong đường dẫn
        return "/components/boardContent/ds-muon-phong-hoc";
    }

    @RequestMapping("/MPH")
    public String showLoginForm() {
        // Yêu cầu: 
            // setAttribute UIDRegular để truy cập trang
            // thay đổi nội dung phần javascript trong đường dẫn
        return "/home/HomeManager";
    }
}