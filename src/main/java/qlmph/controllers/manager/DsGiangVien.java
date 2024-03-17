package qlmph.controllers.manager;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import qlmph.DAO.QLTaiKhoan.GiangVienDAO;
import qlmph.models.QLTaiKhoan.GiangVien;
import qlmph.services.GiangVienService;

@Controller
@RequestMapping("/DsGV")
public class DsGiangVien {
    
    @RequestMapping("/XemDsGV")
    public String showDsGV(Model model) {
    	// Mẫu gửi dữ liệu
//    	GiangVien giangVien = new GiangVien(null, null, "Nguyễn Thị Bích Nguyên", null, (byte) 0, null, null, null, null);
//    	GiangVienDAO.post(giangVien);
    	
    	List<GiangVien> dsGiangVien = GiangVienService.getAll();
    	
    	// Thiết lập khối dữ liệu hiển thị
		model.addAttribute("DsGiangVien", dsGiangVien);
		
		// Thiết lập chuyển hướng trang kế tiếp theo điều kiện Usecase và tương tác View
		model.addAttribute("NextUsecaseTable", "DsMPH");
		model.addAttribute("NextUsecasePathTable", "XemDsMPH");
		
    	return "components/boardContent/ds-giang-vien";
    }
}