package qlmph.controllers.manager;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/DsGV")
public class DsGiangVien {
    
    @RequestMapping("/XemDsGV")
    public String showDsGV() {
        // Yêu cầu truy cập: (đã sử lý bằng sessionStorage/javascript)
            // dữ liệu điều kiện: UIDManager để truy cập trang
            // điều chỉnh nội dung trong javascript để tương thích dữ liệu
    	return "components/boardContent/ds-giang-vien";
    }
}