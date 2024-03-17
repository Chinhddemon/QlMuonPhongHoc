package qlmph.controllers.regular;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import qlmph.bean.TTLopHocBean;


@Controller
@RequestMapping("/DPH")
public class DoiPhongHoc {
    
    @RequestMapping("/ChonLH")
    public String showChonLhScreen() {
        // Yêu cầu: 
            // setAttribute UIDRegular để truy cập trang
            // thay đổi nội dung phần javascript trong đường dẫn
        return "components/boardContent/ds-lop-hoc";
    }

    @RequestMapping("/DPH")
    public String showDPHScreen(Model model) {
    	List<TTLopHocBean> DsLopHoc = new ArrayList<>();
    	
        // Yêu cầu: 
            // setAttribute UIDRegular để truy cập trang
            // thay đổi nội dung phần javascript trong đường dẫn
        return "components/boardContent/tt-muon-phong-hoc";
    }

}
