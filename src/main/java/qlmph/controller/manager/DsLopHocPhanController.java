package qlmph.controller.manager;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import qlmph.model.QLThongTin.LopHocPhan;
import qlmph.model.QLThongTin.LopHocPhanSection;
import qlmph.service.LopHocPhanService;

@Controller
@RequestMapping("/DsLHP")
public class DsLopHocPhanController {
	
	@Autowired
    LopHocPhanService lopHocPhanService;
    
    @RequestMapping("/XemDsLHP")
    public String showDsLHP(Model model) {

   		Map<LopHocPhan, LopHocPhanSection> DsLopHocPhan = lopHocPhanService.layDanhSach();
		
    	// Thiết lập khối dữ liệu hiển thị
		model.addAttribute("DsLopHocPhan", DsLopHocPhan);
		
		// Thiết lập chuyển hướng trang kế tiếp theo điều kiện Usecase và tương tác View
		model.addAttribute("NextUsecaseTableOption1", "CTLHP");
		model.addAttribute("NextUsecasePathTableOption1", "XemCTLHP");

		model.addAttribute("NextUsecaseTableOption2", "CTLHP");
		model.addAttribute("NextUsecasePathTableOption2", "SuaCTLHP");

		model.addAttribute("NextUsecaseTableOption3", "CTLHP");
		model.addAttribute("NextUsecasePathTableOption3", "XoaCTLHP");

		model.addAttribute("NextUsecaseTableOption4", "DsMPH");
		model.addAttribute("NextUsecasePathTableOption4", "XemDsMPH");
    	
        return "components/boardContent/ds-lop-hoc-phan";
    }

	@RequestMapping("/ThemTTMPH")
    public String showThemTTMPH(Model model) {

		Map<LopHocPhan, LopHocPhanSection> DsLopHocPhan = lopHocPhanService.layDanhSach();
    	
    	// Thiết lập khối dữ liệu hiển thị
		model.addAttribute("DsLopHocPhan", DsLopHocPhan);
		
		// Thiết lập chuyển hướng trang kế tiếp theo điều kiện Usecase và tương tác View
		model.addAttribute("NextUsecaseTableRowChoose", "CTMPH");
		model.addAttribute("NextUsecasePathTableRowChoose", "ThemTTMPH");
    	
        return "components/boardContent/ds-lop-hoc-phan";
    }
}
