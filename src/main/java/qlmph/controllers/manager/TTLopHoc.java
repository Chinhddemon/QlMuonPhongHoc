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
    		@RequestParam ("IdLH") int IdLH,
    		Model model) {

    	// Tạo khối dữ liệu hiển thị
    	TTLopHocBean tTLopHoc = TTLopHocService.getIdLH(IdLH);

    	// Thiết lập khối dữ liệu hiển thị
    	model.addAttribute("TTLopHoc", tTLopHoc);

        // Thiết lập chuyển hướng trang kế tiếp theo điều kiện Usecase và tương tác View

        return "components/boardContent/tt-lop-hoc";
    }

    @RequestMapping("SuaTTLH")
    public String showSuaTTLHScreen(
    		@RequestParam ("IdLH") int IdLH,
    		Model model) {
    	// Tạo khối dữ liệu hiển thị
    	TTLopHocBean tTLopHoc = TTLopHocService.getIdLH(IdLH);
    	// Thiết lập khối dữ liệu hiển thị
    	model.addAttribute("TTLopHoc", tTLopHoc);

        // Thiết lập chuyển hướng trang kế tiếp theo điều kiện Usecase và tương tác View

        return "components/boardContent/tt-lop-hoc";
    }
}
