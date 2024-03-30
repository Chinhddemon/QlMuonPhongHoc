package qlmph.controller.manager;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import qlmph.model.QLTaiKhoan.NguoiMuonPhong;
import qlmph.model.QLThongTin.LichMuonPhong;
import qlmph.service.LichMuonPhongService;
import qlmph.service.NguoiMuonPhongService;


@Controller
@RequestMapping("/CTMPH")
public class CTMuonPhongHoc {

	@Autowired
    LichMuonPhongService lichMuonPhongService;

	@Autowired
    NguoiMuonPhongService nguoiMuonPhongService;
    
    @RequestMapping("/XemTTMPH")
    public String showTTMPHScreen(Model model,
    		@RequestParam ("IdLichMPH") int IdLichMPH) {

		// Tạo khối dữ liệu hiển thị
		LichMuonPhong CTLichMPH = lichMuonPhongService.layThongTin(IdLichMPH);
		NguoiMuonPhong NgMPH = null;
		if(CTLichMPH.getMuonPhongHoc() != null) {
			NgMPH = nguoiMuonPhongService.layThongTin(CTLichMPH.getMuonPhongHoc().getMaNgMPH());
		}
		
		// Thiết lập khối dữ liệu hiển thị
		model.addAttribute("CTLichMPH", CTLichMPH);
		model.addAttribute("NgMPH", NgMPH);
		
		// Thiết lập chuyển hướng trang kế tiếp theo điều kiện Usecase và tương tác View
		
        return "components/boardContent/ct-muon-phong-hoc";
    }
    
    @RequestMapping("/SuaTTMPH")
    public String showSuaTTMPHScreen(Model model,
    		@RequestParam ("IdLichMPH") int IdLichMPH) {

    	// Tạo khối dữ liệu hiển thị
		LichMuonPhong CTLichMPH = lichMuonPhongService.layThongTin(IdLichMPH);
		
		// Thiết lập khối dữ liệu hiển thị
		model.addAttribute("CTLichMPH", CTLichMPH);
		
		// Thiết lập chuyển hướng trang kế tiếp theo điều kiện Usecase và tương tác View
		
        return "components/boardContent/ct-muon-phong-hoc";
    }
    
    @RequestMapping("/ThemTTMPH")
    public String showThemTTMPHScreen(Model model) {
		
		// Tạo khối dữ liệu hiển thị
		
		// Thiết lập khối dữ liệu hiển thị
		
		// Thiết lập chuyển hướng trang kế tiếp theo điều kiện Usecase và tương tác View
		
		return "components/boardContent/ct-muon-phong-hoc";
    }
    
}
