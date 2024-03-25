package qlmph.controllers.manager;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import qlmph.bean.TTLichMPHBean;
import qlmph.services.TTLichMPHService;

@Controller
@RequestMapping("/DsMPH")
public class DsMuonPhongHoc {
	
	@RequestMapping("/XemDsMPH")
	public String showDsMPH(Model model) {
		// Mẫu xử lý service
		// List<TTLichMPHBean> dsLichMPH = TTLichMPHService.getAll();
		
		// Tạo khối dữ liệu hiển thị
		// Mẫu dữ liệu
		List<TTLichMPHBean> dsLichMPH = TTLichMPHService.getAll();
		
		dsLichMPH.add(new TTLichMPHBean());
		
		// Thiết lập khối dữ liệu hiển thị
		model.addAttribute("DsLichMPH", dsLichMPH);
		
		// Thiết lập chuyển hướng trang kế tiếp theo điều kiện Usecase và tương tác View
		model.addAttribute("NextUsecaseTable", "TTMPH");
		model.addAttribute("NextUsecasePathTable", "XemTTMPH");

		return "components/boardContent/ds-muon-phong-hoc";
	}

}