package QlMuonPhongHoc.controller.regular;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.Controller;

@Controller
@RequestMapping("/MPH")
public class DsMuonPhongHoc {
    
    @RequestMapping("/ChonLMPH")
    public String showLoginForm() {
        // Yêu cầu: 
            // setAttribute UIDRegular để truy cập trang
            // thay đổi nội dung phần javascript trong đường dẫn
        return "/home/HomeManager";
    }

    @RequestMapping("/MPH")
    public String showLoginForm() {
        // Yêu cầu: 
            // setAttribute UIDRegular để truy cập trang
            // thay đổi nội dung phần javascript trong đường dẫn
        return "/home/HomeManager";
    }
}