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
    public String showXemTTLHScreen(
    		@RequestParam ("MaLH") String MaLH,
    		Model model) {
    	// Tạo khối dữ liệu hiển thị
    	TTLopHocBean tTLopHoc = TTLopHocService.getByMaLH(MaLH);
    	// Thiết lập khối dữ liệu hiển thị
    	model.addAttribute("TTLopHoc", tTLopHoc);
        // Yêu cầu: 
            // setAttribute UIDRegular để truy cập trang
            // thay đổi nội dung phần javascript trong đường dẫn
        return "components/boardContent/tt-lop-hoc";
    }

    @RequestMapping("SuaTTLH")
    public String showSuaTTLHScreen(
    		@RequestParam ("MaLH") String MaLH,
    		Model model) {
    	// Tạo khối dữ liệu hiển thị
    	TTLopHocBean tTLopHoc = TTLopHocService.getByMaLH(MaLH);
    	// Thiết lập khối dữ liệu hiển thị
    	model.addAttribute("TTLopHoc", tTLopHoc);
        // Yêu cầu: 
            // setAttribute UIDRegular để truy cập trang
            // thay đổi nội dung phần javascript trong đường dẫn
        return "components/boardContent/tt-lop-hoc";
    }
}
