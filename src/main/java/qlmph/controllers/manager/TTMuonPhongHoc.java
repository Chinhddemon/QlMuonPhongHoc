package qlmph.controllers.manager;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import qlmph.bean.TTLichMPHBean;

@Controller
@RequestMapping("/TTMPH")
public class TTMuonPhongHoc {
    
    @RequestMapping("/XemTTMPH")
    public String showTTMPHScreen(Model model) {
		// Mẫu xử lý service
		// TTLichMPHBean tTLichMPH = TTLichMPHService.getByIdLMPH();
		
		// Tạo khối dữ liệu hiển thị
		// Mẫu dữ liệu
		TTLichMPHBean tTLichMPH = new TTLichMPHBean();
		
		// Thiết lập khối dữ liệu hiển thị
		model.addAttribute("TTLichMPH", tTLichMPH);
		
		// Thiết lập chuyển hướng trang kế tiếp theo điều kiện Usecase và tương tác View
		
        return "components/boardContent/tt-muon-phong-hoc";
    }
    
    @RequestMapping("/SuaTTMPH")
    public String showSuaTTMPHScreen(Model model) {
		// Mẫu xử lý service
		// TTLichMPHBean tTLichMPH = TTLichMPHService.getByIdLMPH();
		
		// Tạo khối dữ liệu hiển thị
		// Mẫu dữ liệu
		TTLichMPHBean tTLichMPH = new TTLichMPHBean();
		
		// Thiết lập khối dữ liệu hiển thị
		model.addAttribute("TTLichMPH", tTLichMPH);
		
		// Thiết lập chuyển hướng trang kế tiếp theo điều kiện Usecase và tương tác View
    	
        return "components/boardContent/tt-muon-phong-hoc";
    }
    
    @RequestMapping("/ThemTTMPH")
    public String showThemTTMPHScreen(Model model) {
    	// Mẫu xử lý service
		
		// Tạo khối dữ liệu hiển thị
		
		// Thiết lập khối dữ liệu hiển thị
		
		// Thiết lập chuyển hướng trang kế tiếp theo điều kiện Usecase và tương tác View
		
		return "components/boardContent/tt-muon-phong-hoc";
    }
    
}
