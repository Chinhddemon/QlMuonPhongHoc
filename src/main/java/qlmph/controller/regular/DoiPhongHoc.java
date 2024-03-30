package qlmph.controller.regular;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import qlmph.model.QLThongTin.LopHoc;
import qlmph.service.LopHocService;


@Controller
@RequestMapping("/DPH")
public class DoiPhongHoc {
    @Autowired
    LopHocService lopHocService;
    
    @RequestMapping("/ChonLH")
    public String showChonLhScreen(Model model) {
    	
   		List<LopHoc> DsLopHoc = lopHocService.xemDsThongTin();
    	
    	// Thiết lập khối dữ liệu hiển thị
		model.addAttribute("DsLopHoc", DsLopHoc);
		
		// Thiết lập chuyển hướng trang kế tiếp theo điều kiện Usecase và tương tác View
		model.addAttribute("NextUsecaseTable", "DPH");
		model.addAttribute("NextUsecasePathTable", "DPH");
        // Yêu cầu: 
            // setAttribute UIDRegular để truy cập trang
            // thay đổi nội dung phần javascript trong đường dẫn
        return "components/boardContent/ds-lop-hoc";
    }

    @RequestMapping("/DPH")
    public String showDPHScreen(
    		@RequestParam ("IdLH") int IdLH,
    		Model model) {
    	TTLopHocBean tTLopHoc = TTLopHocService.getIdLH(IdLH);
    	// Thiết lập khối dữ liệu hiển thị
		model.addAttribute("TTLopHoc", tTLopHoc);
		
		// Thiết lập chuyển hướng trang kế tiếp theo điều kiện Usecase và tương tác View
		model.addAttribute("NextUsecaseTable", null);
		model.addAttribute("NextUsecasePathTable", null);
        // Yêu cầu: 
            // setAttribute UIDRegular để truy cập trang
            // thay đổi nội dung phần javascript trong đường dẫn
        return "components/boardContent/ct-muon-phong-hoc";
    }

}
