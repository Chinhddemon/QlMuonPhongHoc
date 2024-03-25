package qlmph.controllers.regular;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import qlmph.bean.TTLichMPHBean;

@Controller
@RequestMapping("/MPH")
public class MuonPhongHoc {
    
    @RequestMapping("/ChonLMPH")
    public String showDsMPH(Model model) {
    	
    	// Mẫu xử lý service
		// List<TTLichMPHBean> dsLichMPH = TTLichMPHService.getAll();
		
		// Tạo khối dữ liệu hiển thị
		// Mẫu dữ liệu
		List<TTLichMPHBean> dsLichMPH = new ArrayList<TTLichMPHBean>();
		
		// Thiết lập khối dữ liệu hiển thị
		model.addAttribute("DsLichMPH", dsLichMPH);
		
		// Thiết lập chuyển hướng trang kế tiếp theo điều kiện Usecase và tương tác View
		model.addAttribute("NextUsecaseTable", "MPH");
		model.addAttribute("NextUsecasePathTable", "MPH");
		
        return "components/boardContent/ds-muon-phong-hoc";
    }

    @RequestMapping("/MPH")
    public String showLoginForm(Model model) {
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
}