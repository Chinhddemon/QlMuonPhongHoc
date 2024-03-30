package qlmph.controller.manager;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import qlmph.model.QLThongTin.LopHocPhan;
import qlmph.service.LopHocPhanService;

@Controller
@RequestMapping("/DsLHP")
public class DsLopHoc {
	@Autowired
    LopHocPhanService lopHocPhanService;
    
    @RequestMapping("/XemDsLHP")
    public String showDsLHP(Model model) {

   		List<LopHocPhan> DsLopHocPhan = lopHocPhanService.layDanhSach();
    	
    	// Thiết lập khối dữ liệu hiển thị
		model.addAttribute("DsLopHocPhan", DsLopHocPhan);
		
		// Thiết lập chuyển hướng trang kế tiếp theo điều kiện Usecase và tương tác View
		model.addAttribute("NextUsecaseTable", "DsMPH");
		model.addAttribute("NextUsecasePathTable", "XemDsMPH");
    	
        return "components/boardContent/ds-lop-hoc-phan";
    }
    
}
