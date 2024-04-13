package qlmph.controller.manager;

import java.util.Date;
import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import qlmph.model.QLTaiKhoan.QuanLy;
import qlmph.model.QLThongTin.LichMuonPhong;
import qlmph.model.QLThongTin.LopHocPhanSection;
import qlmph.model.QLThongTin.PhongHoc;
import qlmph.service.LichMuonPhongService;
import qlmph.service.LopHocPhanSectionService;
import qlmph.service.NguoiMuonPhongService;
import qlmph.service.PhongHocService;
import qlmph.service.QuanLyService;

@Controller
@RequestMapping("/CTMPH")
public class CTMuonPhongHoc {

	@Autowired
    private ServletContext servletContext;

	@Autowired
    LichMuonPhongService lichMuonPhongService;

	@Autowired
    LopHocPhanSectionService lopHocPhanSectionService;

	@Autowired
    NguoiMuonPhongService nguoiMuonPhongService;

	@Autowired
	QuanLyService quanLyService;

	@Autowired
	PhongHocService phongHocService;
    
    @RequestMapping("/XemTTMPH")
    public String showTTMPHScreen(Model model,
			@RequestParam("UID") String uid,
    		@RequestParam ("IdLichMPH") int IdLichMPH) {

		// Tạo khối dữ liệu hiển thị
		LichMuonPhong CTLichMPH = lichMuonPhongService.layThongTin(IdLichMPH);
		
		// Thiết lập khối dữ liệu hiển thị
		model.addAttribute("CTLichMPH", CTLichMPH);
		
		// Thiết lập chuyển hướng trang kế tiếp
		
        return "components/boardContent/ct-muon-phong-hoc";
    }
    
    @RequestMapping("/SuaTTMPH")
    public String showSuaTTMPHScreen(Model model,
			@RequestParam("UID") String uid,
    		@RequestParam ("IdLichMPH") int IdLichMPH) {

    	// Tạo khối dữ liệu hiển thị
		LichMuonPhong CTLichMPH = lichMuonPhongService.layThongTin(IdLichMPH);
		
		// Thiết lập dữ liệu để hiển thị
		model.addAttribute("CTLichMPH", CTLichMPH);
		
		// Thiết lập chuyển hướng trang kế tiếp
		
        return "components/boardContent/ct-muon-phong-hoc";
    }
    
    @RequestMapping("/ThemTTMPH")
    public String showThemTTMPHScreen(Model model,
			@RequestParam("UID") String uid,
			@RequestParam ("IdLHP") int IdLHP) {
		
		// Lấy dữ liệu
		String UIDManager = (String) servletContext.getAttribute("UIDManager");
		if (UIDManager == null || UIDManager.isEmpty()) {
			new Exception("Quản lý chưa đăng nhập.").printStackTrace();
			return "components/boardContent/ct-muon-phong-hoc";
		}

		// Tạo dữ liệu để hiển thị
		QuanLy QuanLyKhoiTao = quanLyService.layThongTinTaiKhoan(UIDManager);
		LopHocPhanSection CTLopHocPhanSection = lopHocPhanSectionService.layThongTin(IdLHP);
		List<PhongHoc> DsPhongHoc = phongHocService.layDanhSach();
		
		// Thiết lập dữ liệu để hiển thị
		model.addAttribute("CTLopHocPhanSection", CTLopHocPhanSection);
		model.addAttribute("QuanLyKhoiTao", QuanLyKhoiTao);
		model.addAttribute("DsPhongHoc", DsPhongHoc);
		
		// Thiết lập chuyển hướng trang kế tiếp
		
        return "components/boardContent/ct-muon-phong-hoc";
    }

	@RequestMapping(value = "/ThemTTMPH", method = RequestMethod.POST)
    public String submit(Model model,
			RedirectAttributes redirectAttributes,
			@RequestParam("UID") String uid,
			@RequestParam("XacNhan") String XacNhan,
			@RequestParam("IdLHPSecTion") int IdLHPSection,
			@RequestParam("MaPH") String MaPH,
			@RequestParam("ThoiGian_BD") Date ThoiGian_BD,
			@RequestParam("ThoiGian_KT") Date ThoiGian_KT,
			@RequestParam("MucDich") String MucDich,
			@RequestParam(value = "LyDo", required = false, defaultValue = "") String LyDo) {

		// Lấy dữ liệu
		String token = (String) servletContext.getAttribute("token");
		if (token == null || token.isEmpty() || !XacNhan.equals(token)) {
			new Exception("Mã xác nhận không đúng.").printStackTrace();
			return "components/boardContent/ct-muon-phong-hoc";
		}
	
		String UIDManager = (String) servletContext.getAttribute("UIDManager");
		if (UIDManager == null || UIDManager.isEmpty()) {
			new Exception("Quản lý chưa đăng nhập.").printStackTrace();
			return "components/boardContent/ct-muon-phong-hoc";
		}

		QuanLy QuanLyKhoiTao = quanLyService.layThongTinTaiKhoan(UIDManager);
		if (QuanLyKhoiTao == null) {
			new Exception("Không tìm thấy thông tin quản lý.").printStackTrace();
			return "components/boardContent/ct-muon-phong-hoc";
		}

		//Tạo dữ liệu và lưu vào hệ thống
		LichMuonPhong CTLichMPH = lichMuonPhongService.luuThongTin(
			new LichMuonPhong(
				lopHocPhanSectionService.layThongTin(IdLHPSection),
				phongHocService.layThongTin(MaPH),
				QuanLyKhoiTao,
				ThoiGian_BD,
				ThoiGian_KT,
				MucDich,
				LyDo));

		if (CTLichMPH == null) {
			redirectAttributes.addFlashAttribute("errorMessage", "Không thể tạo thông tin mượn phòng.");
			return "redirect:/XemTTMPH/ThemTTMPH.htm";
		}

		redirectAttributes.addFlashAttribute("errorMessage", "Tạo thông tin thành công");
        return "redirect:../CTMPH/XemTTMPH.htm?UID=" + uid + "&IdLichMPH=" + Integer.parseInt(CTLichMPH.getIdLMPH());
    }
}
