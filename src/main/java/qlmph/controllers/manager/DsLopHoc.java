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
    	
    	model.addAttribute("DsLopHoc", DsLopHoc);
        // Yêu cầu truy cập: (đã sử lý bằng sessionStorage/javascript)
            // dữ liệu điều kiện: UIDManager để truy cập trang
            // điều chỉnh nội dung trong javascript để tương thích dữ liệu
        return "components/boardContent/ds-lop-hoc";
    }
}
