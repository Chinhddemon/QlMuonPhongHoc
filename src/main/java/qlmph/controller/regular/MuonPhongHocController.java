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
import qlmph.model.QLTaiKhoan.QuanLy;
import qlmph.model.QLThongTin.LichMuonPhong;
import qlmph.service.LichMuonPhongService;
import qlmph.service.MuonPhongHocService;
import qlmph.service.NguoiMuonPhongService;
import qlmph.service.QuanLyService;

@Controller
@RequestMapping("/MPH")
public class MuonPhongHocController {

	@Autowired
    private ServletContext servletContext;

	@Autowired
    LichMuonPhongService lichMuonPhongService;

	@Autowired
	MuonPhongHocService muonPhongHocService;

	@Autowired
    NguoiMuonPhongService nguoiMuonPhongService;

	@Autowired
    QuanLyService quanLyService;
    
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
		model.addAttribute("NextUsecaseSubmitOption2", "MPH");
		model.addAttribute("NextUsecasePathSubmitOption2", "MPH");
    	
        return "components/boardContent/ct-muon-phong-hoc";
    }

	@RequestMapping(value = "/MPH", method = RequestMethod.POST)
    public String submit(Model model,
			@RequestParam ("IdLichMPH") int IdLichMPH,
			@RequestParam("UID") String uid,
			@RequestParam("YeuCau") String YeuCau,
			@RequestParam("XacNhan") String XacNhan) {

		// Lấy khối dữ liệu chỉnh sửa	
		LichMuonPhong CTLichMPH = lichMuonPhongService.layThongTin(IdLichMPH);
		NguoiMuonPhong NgMPH = nguoiMuonPhongService.layThongTinTaiKhoan(uid);
		String token = (String) servletContext.getAttribute("token");
		if(token != null && !token.isEmpty() && uid != null && !uid.isEmpty() && XacNhan.equals(token)) {
			String UIDManager = (String) servletContext.getAttribute("UIDManager");
			if(UIDManager != null && !UIDManager.isEmpty()) {
				QuanLy QuanLy = quanLyService.layThongTinTaiKhoan(UIDManager);
				if(muonPhongHocService.taoThongTin(CTLichMPH, NgMPH, QuanLy, YeuCau)) {
					System.out.println("Tạo thông tin thành công.");
				} else {
					System.out.println("Không thể tạo thông tin");
				}
			}
			else  {
				System.out.println("Quản lý chưa đăng nhập.");
			}
			
		} else {
			System.out.println("Mã xác nhận không đúng.");
		}

		// Thiết lập chuyển hướng trang kế tiếp theo điều kiện Usecase và tương tác View
		model.addAttribute("NextUsecaseSubmitOption2", "MPH");
		model.addAttribute("NextUsecasePathSubmitOption2", "MPH");

        return "components/boardContent/ct-muon-phong-hoc";
    }
}