package qlmph.controller.regular;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/DPH")
public class DoiPhongHoc {
    
    @RequestMapping("/ChonLH")
    public String showDsLH() {
        // Yêu cầu: 
            // setAttribute UIDRegular để truy cập trang
            // thay đổi nội dung phần javascript trong đường dẫn
        return "/components/boardContent/ds-lop-hoc";
    }

    @RequestMapping("/DPH")
    public String showLoginForm() {
        // Yêu cầu: 
            // setAttribute UIDRegular để truy cập trang
            // thay đổi nội dung phần javascript trong đường dẫn
        return "/home/HomeManager";
    }

}
