package qlmph.controllers.manager;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import qlmph.services.TTLopHocService;
import qlmph.bean.TTLopHocBean;

@Controller
@RequestMapping("/DsLH")
public class DsLopHoc {
    
    @RequestMapping("/XemDsLH")
    public String showDsLH(Model model) {
    	List<TTLopHocBean> DsLopHoc = TTLopHocService.getAll();
    	
    	DsLopHoc.add(new TTLopHocBean());
    	
    	// Thiết lập khối dữ liệu hiển thị
		model.addAttribute("DsLopHoc", DsLopHoc);
		
		// Thiết lập chuyển hướng trang kế tiếp theo điều kiện Usecase và tương tác View
		model.addAttribute("NextUsecaseTable", "DsMPH");
		model.addAttribute("NextUsecasePathTable", "XemDsMPH");
    	
        return "components/boardContent/ds-lop-hoc";
    }
    
}
