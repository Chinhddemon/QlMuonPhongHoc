package qlmph.controllers.manager;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import qlmph.DAO.QLThongTin.MonHocDAO;
import qlmph.bean.TTLichMPHBean;
import qlmph.models.QLThongTin.MonHoc;

@Controller
@RequestMapping("/DsMPH")
public class DsMuonPhongHoc {
	
	@RequestMapping("/XemDsMPH")
	public String showDsMPH(Model model) {
		// Test lấy dữ liệu 
		MonHoc monHoc = MonHocDAO.getByMaMH("INT1340");
		System.out.println(monHoc);
		
		// Tạo khối dữ liệu hiển thị
		List<TTLichMPHBean> dsLichMPH = new ArrayList<TTLichMPHBean>();
	
		// Dữ liệu mẫu
		dsLichMPH.add(new TTLichMPHBean("D100214", "Nguyễn Thị Bích Nguyên", "D21DCCN01-N", "INT1340", "Nhập môn công nghệ phầm mềm",
				"2A08", "13:00 29/02/2024", "16:30 29/2/2024", "Học lý thuyết", "Đổi phòng học khác", "Đã mượn", "Ngô Cao Hy", "Sinh Viên", "Thái Văn Anh Chính",
				"12:58 28/2/2024", "MC + K + MT"));
		
		dsLichMPH.add(new TTLichMPHBean("D100214", "Nguyễn Thành Trung", "D21DCCN01-N", "INT1340", "Nhập môn công nghệ phầm mềm",
				"2A08", "13:00 28/02/2024", "16:30 28/2/2024", "Học lý thuyết", "Đổi phòng học khác", "Đã mượn", "Ngô Cao Hy", "Sinh Viên", "Thái Văn Anh Chính",
				"12:58 28/2/2024", "MC + K + MT"));
		
		dsLichMPH.add(new TTLichMPHBean("D100214", "Nguyễn Thành Trung", "D21DCCN01-N", "INT1340", "Nhập môn công nghệ phầm mềm",
				"2A08", "13:00 30/02/2024", "16:30 30/2/2024", "Học lý thuyết", "Đổi phòng học khác", "Đã mượn", "Ngô Cao Hy", "Sinh Viên", "Thái Văn Anh Chính",
				"12:58 28/2/2024", "MC + K + MT"));
		
		// Thiết lập khối dữ liệu hiển thị
		model.addAttribute("DsLichMPH", dsLichMPH);
		
		// Thiết lập chuyển hướng trang kế tiếp theo điều kiện Usecase và tương tác View
		model.addAttribute("NextUsecaseTable", "TTMPH");
		model.addAttribute("NextUsecasePathTable", "XemTTMPH");

		return "components/boardContent/ds-muon-phong-hoc";
	}

}