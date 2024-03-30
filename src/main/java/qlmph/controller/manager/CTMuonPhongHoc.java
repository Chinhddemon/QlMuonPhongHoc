package qlmph.controller.manager;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import qlmph.bean.TTLichMPHBean;
import qlmph.service.TTLichMPHService;

@Controller
@RequestMapping("/TTMPH")
public class CTMuonPhongHoc {
    
    @RequestMapping("/XemTTMPH")
    public String showTTMPHScreen(Model model,
    		@RequestParam ("IdLichMPH") String IdLichMPH) {
		TTLichMPHBean tTLichMPH = TTLichMPHService.getByIdLMPH(IdLichMPH);
		
		// Thiết lập khối dữ liệu hiển thị
		model.addAttribute("TTLichMPH", tTLichMPH);
		
		// Thiết lập chuyển hướng trang kế tiếp theo điều kiện Usecase và tương tác View
		
        return "components/boardContent/ct-muon-phong-hoc";
    }
    
    @RequestMapping("/SuaTTMPH")
    public String showSuaTTMPHScreen(Model model,
    		@RequestParam ("IdLichMPH") String IdLichMPH) {
    	TTLichMPHBean tTLichMPH = TTLichMPHService.getByIdLMPH(IdLichMPH);
		
		// Thiết lập khối dữ liệu hiển thị
		model.addAttribute("TTLichMPH", tTLichMPH);
		
		// Thiết lập chuyển hướng trang kế tiếp theo điều kiện Usecase và tương tác View
    	
        return "components/boardContent/ct-muon-phong-hoc";
    }
    
    @RequestMapping("/ThemTTMPH")
    public String showThemTTMPHScreen(Model model) {
    	// Mẫu xử lý service
		
		// Tạo khối dữ liệu hiển thị
		
		// Thiết lập khối dữ liệu hiển thị
		
		// Thiết lập chuyển hướng trang kế tiếp theo điều kiện Usecase và tương tác View
		
		return "components/boardContent/ct-muon-phong-hoc";
    }
    
}
