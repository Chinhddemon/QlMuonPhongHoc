package qlmph.controller.manager;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import qlmph.model.QLThongTin.LopHoc;
import qlmph.service.LopHocService;

@Controller
@RequestMapping("/DsLH")
public class DsLopHoc {
	@Autowired
    LopHocService lopHocService;
    
    @RequestMapping("/XemDsLH")
    public String showDsLH(Model model) {

   		List<LopHoc> DsLopHoc = lopHocService.xemDanhSach();
    	
    	// Thiết lập khối dữ liệu hiển thị
		model.addAttribute("DsLopHoc", DsLopHoc);
		
		// Thiết lập chuyển hướng trang kế tiếp theo điều kiện Usecase và tương tác View
		model.addAttribute("NextUsecaseTable", "DsMPH");
		model.addAttribute("NextUsecasePathTable", "XemDsMPH");
    	
        return "components/boardContent/ds-lop-hoc";
    }
    
}
