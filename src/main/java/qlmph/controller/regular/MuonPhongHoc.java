package qlmph.controller.regular;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import qlmph.model.QLTaiKhoan.NguoiMuonPhong;
import qlmph.model.QLThongTin.LichMuonPhong;
import qlmph.service.LichMuonPhongService;
import qlmph.service.NguoiMuonPhongService;
import qlmph.utils.UUIDEncoderDecoder;

@Controller
@RequestMapping("/MPH")
public class MuonPhongHoc {

	@Autowired
    LichMuonPhongService lichMuonPhongService;

	@Autowired
    NguoiMuonPhongService nguoiMuonPhongService;
    
    @RequestMapping("/ChonLMPH")
    public String showDsMPH(Model model) {
    	
		// Tạo khối dữ liệu hiển thị
		List<LichMuonPhong> dsLichMPH = lichMuonPhongService.layDanhSach();
		
		// Thiết lập khối dữ liệu hiển thị
		model.addAttribute("DsLichMPH", dsLichMPH);
		
		// Thiết lập chuyển hướng trang kế tiếp theo điều kiện Usecase và tương tác View
		model.addAttribute("NextUsecaseTable", "MPH");
		model.addAttribute("NextUsecasePathTable", "MPH");
		
        return "components/boardContent/ds-lich-muon-phong";
    }

    @RequestMapping("/MPH")
    public String showLoginForm(Model model,
    		@RequestParam ("IdLichMPH") int IdLichMPH,
			@RequestParam("UID") String uid) {
    	// Tạo khối dữ liệu hiển thị
		LichMuonPhong CTLichMPH = lichMuonPhongService.layThongTin(IdLichMPH);
		NguoiMuonPhong NgMPH = nguoiMuonPhongService.layThongTinTaiKhoan(uid);
		
		// Thiết lập khối dữ liệu hiển thị
		model.addAttribute("CTLichMPH", CTLichMPH);
		model.addAttribute("NgMPH", NgMPH);
		
		// Thiết lập chuyển hướng trang kế tiếp theo điều kiện Usecase và tương tác View
    	
        return "components/boardContent/ct-muon-phong-hoc";
    }
}