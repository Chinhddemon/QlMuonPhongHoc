package qlmph.controllers.manager;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import qlmph.bean.TTLichMPH;

@Controller
@RequestMapping("/TTMPH")
public class TTMuonPhongHoc {
    
    @RequestMapping("/XemTTMPH")
    public String showTTMPHScreen(Model model) {
    	
    	// Dữ liệu mẫu
    	TTLichMPH testLichMPH = new TTLichMPH("D100214", "Nguyễn Thành Trung", "D21DCCN01-N", "INT1340", "Nhập môn công nghệ phầm mềm",
				"2A08", "13:00 28/02/2024", "16:30 28/2/2024", "Học lý thuyết", "Đổi phòng học khác", "Đã mượn", "Ngô Cao Hy", "Sinh Viên", "Thái Văn Anh Chính",
				"12:58 28/2/2024", "MC + K + MT");
    	
    	// Thiết lập khối dữ liệu hiển thị
		model.addAttribute("TTLichMPH", testLichMPH);
		
	
		// Thiết lập chuyển hướng trang kế tiếp theo điều kiện Usecase và tương tác View
		model.addAttribute("NextUsecaseTable", "");
		model.addAttribute("NextUsecasePathTable", "");
		
        return "components/boardContent/tt-muon-phong-hoc";
    }
    
    @RequestMapping("/SuaTTMPH")
    public String showSuaTTMPHScreen(Model model) {
    	
    	// Dữ liệu mẫu
    	TTLichMPH testLichMPH = new TTLichMPH("D100214", "Nguyễn Thành Trung", "D21DCCN01-N", "INT1340", "Nhập môn công nghệ phầm mềm",
				"2A08", "13:00 28/02/2024", "16:30 28/2/2024", "Học lý thuyết", "Đổi phòng học khác", "Đã mượn", "Ngô Cao Hy", "Sinh Viên", "Thái Văn Anh Chính",
				"12:58 28/2/2024", "MC + K + MT");
    	// Thiết lập khối dữ liệu hiển thị
    	model.addAttribute("TTLichMPH", testLichMPH);
    	
        return "components/boardContent/tt-muon-phong-hoc";
    }
    
    @RequestMapping("/ThemTTMPH")
    public String showThemTTMPHScreen(Model model) {
    	
    	// Dữ liệu mẫu
    	TTLichMPH testLichMPH = new TTLichMPH("D100214", "Nguyễn Thành Trung", "D21DCCN01-N", "INT1340", "Nhập môn công nghệ phầm mềm",
				"2A08", "13:00 28/02/2024", "16:30 28/2/2024", "Học lý thuyết", "Đổi phòng học khác", "Đã mượn", "Ngô Cao Hy", "Sinh Viên", "Thái Văn Anh Chính",
				"12:58 28/2/2024", "MC + K + MT");
    	// Thiết lập khối dữ liệu hiển thị
    	model.addAttribute("TTLichMPH", testLichMPH);
	
		// Thiết lập chuyển hướng trang kế tiếp theo điều kiện Usecase và tương tác View
		model.addAttribute("NextUsecaseTable", "");
		model.addAttribute("NextUsecasePathTable", "");
		
		return "components/boardContent/tt-muon-phong-hoc";
    }
    
}
