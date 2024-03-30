package qlmph.controller.regular;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import qlmph.model.QLThongTin.LichMuonPhong;
import qlmph.service.LichMuonPhongService;

@Controller
@RequestMapping("/MPH")
public class MuonPhongHoc {

	@Autowired
    LichMuonPhongService lichMuonPhongService;
    
    @RequestMapping("/ChonLMPH")
    public String showDsMPH(Model model) {
    	
		// Tạo khối dữ liệu hiển thị
		List<LichMuonPhong> dsLichMPH = lichMuonPhongService.xemDanhSach();
		
		// Thiết lập khối dữ liệu hiển thị
		model.addAttribute("DsLichMPH", dsLichMPH);
		
		// Thiết lập chuyển hướng trang kế tiếp theo điều kiện Usecase và tương tác View
		model.addAttribute("NextUsecaseTable", "MPH");
		model.addAttribute("NextUsecasePathTable", "MPH");
		
        return "components/boardContent/ds-lich-muon-phong";
    }

    @RequestMapping("/MPH")
    public String showLoginForm(Model model,
    		@RequestParam ("IdLichMPH") String IdLichMPH) {
		// Mẫu xử lý service
		// TTLichMPHBean tTLichMPH = TTLichMPHService.getByIdLMPH();
		
		// Tạo khối dữ liệu hiển thị
		// Mẫu dữ liệu
		TTLichMPHBean tTLichMPH = TTLichMPHService.getByIdLMPH(IdLichMPH);
		
		// Thiết lập khối dữ liệu hiển thị
		model.addAttribute("TTLichMPH", tTLichMPH);
		
		// Thiết lập chuyển hướng trang kế tiếp theo điều kiện Usecase và tương tác View
    	
        return "components/boardContent/ct-muon-phong-hoc";
    }
}