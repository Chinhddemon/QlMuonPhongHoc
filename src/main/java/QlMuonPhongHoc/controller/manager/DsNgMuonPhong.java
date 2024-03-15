package QlMuonPhongHoc.controller.manager;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.Controller;

@Controller
@RequestMapping("/DsNgMPH")
public class DsMuonPhongHoc {
    
    @RequestMapping("/DsNgMPH")
    public String showLoginForm() {
        // Yêu cầu: 
            // setAttribute UIDManager để truy cập trang
            // thay đổi nội dung phần javascript trong đường dẫn
        return "/home/HomeManager";
    }

}