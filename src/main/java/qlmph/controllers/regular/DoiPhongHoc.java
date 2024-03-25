package qlmph.controllers.regular;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import qlmph.bean.TTLopHocBean;
import qlmph.services.TTLopHocService;


@Controller
@RequestMapping("/DPH")
public class DoiPhongHoc {
    
    @RequestMapping("/ChonLH")
    public String showChonLhScreen(Model model) {
    	
    	List<TTLopHocBean> dsLopHoc = TTLopHocService.getAll();
    	
    	// Thiết lập khối dữ liệu hiển thị
		model.addAttribute("DsLopHoc", dsLopHoc);
		
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
    		@RequestParam ("MaLH") int IdLH,
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
        return "components/boardContent/tt-muon-phong-hoc";
    }

}
