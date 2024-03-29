package qlmph.controller.manager;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import qlmph.bean.TTLichMPHBean;
import qlmph.service.TTLichMPHService;

@Controller
@RequestMapping("/DsMPH")
public class DsMuonPhongHoc {
	
	@RequestMapping("/XemDsMPH")
	public String showDsMPH(Model model) {
		
		// Tạo khối dữ liệu hiển thị
		List<TTLichMPHBean> dsLichMPH = TTLichMPHService.getAll();
		
		// Thiết lập khối dữ liệu hiển thị
		model.addAttribute("DsLichMPH", dsLichMPH);
		
		// Thiết lập chuyển hướng trang kế tiếp theo điều kiện Usecase và tương tác View
		model.addAttribute("NextUsecaseTable", "TTMPH");
		model.addAttribute("NextUsecasePathTable", "XemTTMPH");

		return "components/boardContent/ds-muon-phong-hoc";
	}

}