package qlmph.controller.manager;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/TTMPH")
public class TTMuonPhongHoc {
    
    @RequestMapping("XemTTMPH")
    public String showTTMPHScreen() {
        // Yêu cầu: 
            // setAttribute UIDRegular để truy cập trang
            // thay đổi nội dung phần javascript trong đường dẫn
        return "components/boardContent/tt-muon-phong-hoc";
    }

    @RequestMapping("SuaTTMPH")
    public String showSuaTTMPHScreen() {
        // Yêu cầu: 
            // setAttribute UIDRegular để truy cập trang
            // thay đổi nội dung phần javascript trong đường dẫn
        return "/home/HomeManager";
    }
    
}
