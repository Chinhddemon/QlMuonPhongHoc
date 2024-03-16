package qlmph.controller.manager;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import qlmph.bean.TTLichMPH;

@Controller
@RequestMapping("/DsMPH")
public class DsMuonPhongHoc {
	
	@RequestMapping("/XemDsMPH")
	public String showDsMPH(Model model) {
		// Tạo khối dữ liệu hiển thị
		List<TTLichMPH> DsLichMPH = new ArrayList<TTLichMPH>();
	
		// Dữ liệu mẫu
		DsLichMPH.add(new TTLichMPH("D100214", "Nguyễn Thị Bích Nguyên", "D21DCCN01-N", "INT1340", "Nhập môn công nghệ phầm mềm",
				"2A08", "13:00 28/02/2024", "16:30 28/2/2024", "Học lý thuyết", "Đổi phòng học khác", "Đã mượn", "Ngô Cao Hy", "Sinh Viên", "Thái Văn Anh Chính",
				"12:58 28/2/2024", "MC + K + MT"));
		
		DsLichMPH.add(new TTLichMPH("D100214", "Nguyễn Thành Trung", "D21DCCN01-N", "INT1340", "Nhập môn công nghệ phầm mềm",
				"2A08", "13:00 28/02/2024", "16:30 28/2/2024", "Học lý thuyết", "Đổi phòng học khác", "Đã mượn", "Ngô Cao Hy", "Sinh Viên", "Thái Văn Anh Chính",
				"12:58 28/2/2024", "MC + K + MT"));
		
		// Thiết lập khối dữ liệu hiển thị
		model.addAttribute("DsLichMPH", DsLichMPH);
		
		// Thiết lập chuyển hướng trang kế tiếp theo điều kiện Usecase và tương tác View
		model.addAttribute("NextUsecaseTable", "TTMPH");
		model.addAttribute("NextUsecasePathTable", "XemTTMPH");

		return "components/boardContent/ds-muon-phong-hoc";
	}

}