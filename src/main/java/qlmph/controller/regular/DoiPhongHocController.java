package qlmph.controller.regular;

import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import qlmph.model.QLTaiKhoan.NguoiMuonPhong;
import qlmph.model.QLThongTin.LopHocPhan;
import qlmph.service.LopHocPhanService;
import qlmph.service.NguoiMuonPhongService;


@Controller
@RequestMapping("/DPH")
public class DoiPhongHocController {

    @Autowired
    private ServletContext servletContext;

    @Autowired
    LopHocPhanService lopHocPhanService;

    @Autowired
    NguoiMuonPhongService nguoiMuonPhongService;
    
    @RequestMapping("/ChonLHP")
    public String showChonLhScreen(Model model) {
    	
   		List<LopHocPhan> DsLopHocPhan = lopHocPhanService.layDanhSach();
    	
    	// Thiết lập khối dữ liệu hiển thị
		model.addAttribute("DsLopHocPhan", DsLopHocPhan);
		
		// Thiết lập chuyển hướng trang kế tiếp theo điều kiện Usecase và tương tác View
		model.addAttribute("NextUsecaseTable", "DPH");
		model.addAttribute("NextUsecasePathTable", "DPH");
        // Yêu cầu: 
            // setAttribute UIDRegular để truy cập trang
            // thay đổi nội dung phần javascript trong đường dẫn
        return "components/boardContent/ds-lop-hoc-phan";
    }

    @RequestMapping("/DPH")
    public String showDPHScreen(Model model,
    		@RequestParam ("IdLHP") int IdLHP,
			@RequestParam("UID") String uid) {
        LopHocPhan CtLopHocPhan = lopHocPhanService.layThongTin(IdLHP);
        NguoiMuonPhong NgMPH = nguoiMuonPhongService.layThongTinTaiKhoan(uid);
        
    	// Thiết lập khối dữ liệu hiển thị
		model.addAttribute("CTLopHocPhan", CtLopHocPhan);
        model.addAttribute("NgMPH", NgMPH);
		
		// Thiết lập chuyển hướng trang kế tiếp theo điều kiện Usecase và tương tác View
		model.addAttribute("NextUsecaseTable", null);
		model.addAttribute("NextUsecasePathTable", null);
        // Yêu cầu: 
            // setAttribute UIDRegular để truy cập trang
            // thay đổi nội dung phần javascript trong đường dẫn
        return "components/boardContent/ct-muon-phong-hoc";
    }

    @RequestMapping(value = "/DPH", method = RequestMethod.POST)
    public String submit(Model model,
    		@RequestParam ("IdLHP") int IdLHP,
			@RequestParam("UID") String uid) {
        LopHocPhan CtLopHocPhan = lopHocPhanService.layThongTin(IdLHP);
        NguoiMuonPhong NgMPH = nguoiMuonPhongService.layThongTinTaiKhoan(uid);
        
        String token = (String) servletContext.getAttribute("token");
        System.out.println(token);

    	// Thiết lập khối dữ liệu hiển thị
		model.addAttribute("CTLopHocPhan", CtLopHocPhan);
        model.addAttribute("NgMPH", NgMPH);
		
		// Thiết lập chuyển hướng trang kế tiếp theo điều kiện Usecase và tương tác View
		model.addAttribute("NextUsecaseTable", null);
		model.addAttribute("NextUsecasePathTable", null);
        // Yêu cầu: 
            // setAttribute UIDRegular để truy cập trang
            // thay đổi nội dung phần javascript trong đường dẫn
        return "components/boardContent/ct-muon-phong-hoc";
    }

}
