package qlmph.controller.manager;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import qlmph.model.QLThongTin.LichMuonPhong;
import qlmph.service.LichMuonPhongService;

@Controller
@RequestMapping("/DsMPH")
public class DsLichMuonPhong {

	@Autowired
    LichMuonPhongService lichMuonPhongService;
	
	@RequestMapping("/XemDsMPH")
	public String showDsMPH(Model model) {
		
		// Tạo khối dữ liệu hiển thị
		List<LichMuonPhong> dsLichMPH = lichMuonPhongService.xemDanhSach();
		
		// Thiết lập khối dữ liệu hiển thị
		model.addAttribute("DsLichMPH", dsLichMPH);
		
		// Thiết lập chuyển hướng trang kế tiếp theo điều kiện Usecase và tương tác View
		model.addAttribute("NextUsecaseTable", "TTMPH");
		model.addAttribute("NextUsecasePathTable", "XemTTMPH");

		return "components/boardContent/ds-lich-muon-phong";
	}

}