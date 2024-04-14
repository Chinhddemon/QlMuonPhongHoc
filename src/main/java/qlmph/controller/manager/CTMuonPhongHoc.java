package qlmph.controller.manager;

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
import qlmph.utils.Converter;

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
		List<PhongHoc> DsPhongHoc = phongHocService.layDanhSach();
		
		// Thiết lập dữ liệu để hiển thị
		model.addAttribute("CTLichMPH", CTLichMPH);
		model.addAttribute("DsPhongHoc", DsPhongHoc);
		
		// Thiết lập chuyển hướng trang kế tiếp
		model.addAttribute("NextUsecaseSubmitOption1", "CTMPH");
		model.addAttribute("NextUsecasePathSubmitOption1", "SuaTTMPH");
		
        return "components/boardContent/ct-muon-phong-hoc";
    }

	@RequestMapping(value = "/SuaTTMPH", method = RequestMethod.POST)
    public String submitSuaTTMPH(Model model,
			RedirectAttributes redirectAttributes,
			@RequestParam("UID") String uid,
			@RequestParam("XacNhan") String XacNhan,
			@RequestParam("IdLichMPH") String IdLichMPH,
			@RequestParam("IdPH") int IdPH,
			@RequestParam("ThoiGian_BD") String ThoiGian_BD,
			@RequestParam("ThoiGian_KT") String ThoiGian_KT,
			@RequestParam("MucDich") String MucDich,
			@RequestParam("LyDo") String LyDo) {
				
		// Kiểm tra mã xác nhận
		String token = (String) servletContext.getAttribute("token");
		if (token == null || token.isEmpty() || !XacNhan.equals(token)) {
			new Exception("Mã xác nhận không đúng.").printStackTrace();
			return "components/boardContent/ct-muon-phong-hoc";
		}
	
		// Kiểm tra thông tin quản lý
		String UIDManager = (String) servletContext.getAttribute("UIDManager");
		if (UIDManager == null || UIDManager.isEmpty() || !UIDManager.equals(uid)) {
			new Exception("Quản lý chưa đăng nhập.").printStackTrace();
			return "components/boardContent/ct-muon-phong-hoc";
		}

		// Lấy thông tin quản lý
		QuanLy QuanLyKhoiTao = quanLyService.layThongTinTaiKhoan(UIDManager);
		if (QuanLyKhoiTao == null) {
			new Exception("Không tìm thấy thông tin quản lý.").printStackTrace();
			return "components/boardContent/ct-muon-phong-hoc";
		}

		// Lấy thông tin lịch mượn phòng
		LichMuonPhong CTLichMPH = lichMuonPhongService.layThongTin(Integer.parseInt(IdLichMPH));
			CTLichMPH.setPhongHoc(phongHocService.layThongTin(IdPH));
			CTLichMPH.setQuanLyKhoiTao(QuanLyKhoiTao);
			CTLichMPH.setThoiGian_BD(Converter.stringToDatetime(ThoiGian_BD));
			CTLichMPH.setThoiGian_KT(Converter.stringToDatetime(ThoiGian_KT));
			CTLichMPH.setLyDo(LyDo);

		//Tạo dữ liệu và lưu vào hệ thống
		LichMuonPhong newCTLichMPH = lichMuonPhongService.capNhatThongTin(CTLichMPH);
		
		// Kiểm tra kết quả
		if (newCTLichMPH == null) {
			redirectAttributes.addFlashAttribute("errorMessage", "Không thể tạo thông tin mượn phòng.");
			return "redirect:/CTMPH/XemTTMPH.htm?UID=" + uid + "&IdLichMPH=" + Integer.parseInt(IdLichMPH);
		}
		
		redirectAttributes.addFlashAttribute("errorMessage", "Tạo thông tin thành công");
        return "redirect:../CTMPH/XemTTMPH.htm?UID=" + uid + "&IdLichMPH=" + Integer.parseInt(IdLichMPH);
    }
    
    @RequestMapping("/ThemTTMPH")
    public String showThemTTMPHScreen(Model model,
			@RequestParam("UID") String uid,
			@RequestParam ("IdLHP") int IdLHP) {
		
		// Kiểm tra thông tin quản lý
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
		model.addAttribute("NextUsecaseSubmitOption2", "CTMPH");
		model.addAttribute("NextUsecasePathSubmitOption2", "ThemTTMPH");
		
        return "components/boardContent/ct-muon-phong-hoc";
    }

	@RequestMapping(value = "/ThemTTMPH", method = RequestMethod.POST)
    public String submitThemTTMPH(Model model,
			RedirectAttributes redirectAttributes,
			@RequestParam("UID") String uid,
			@RequestParam("XacNhan") String XacNhan,
			@RequestParam("IdLHPSection") String IdLHPSection,
			@RequestParam("IdPH") int IdPH,
			@RequestParam("ThoiGian_BD") String ThoiGian_BD,
			@RequestParam("ThoiGian_KT") String ThoiGian_KT,
			@RequestParam("MucDich") String MucDich) {

		// Kiểm tra mã xác nhận
		String token = (String) servletContext.getAttribute("token");
		if (token == null || token.isEmpty() || !XacNhan.equals(token)) {
			new Exception("Mã xác nhận không đúng.").printStackTrace();
			return "components/boardContent/ct-muon-phong-hoc";
		}
	
		// Kiểm tra thông tin quản lý
		String UIDManager = (String) servletContext.getAttribute("UIDManager");
		if (UIDManager == null || UIDManager.isEmpty() || !UIDManager.equals(uid)) {
			new Exception("Quản lý chưa đăng nhập.").printStackTrace();
			return "components/boardContent/ct-muon-phong-hoc";
		}

		// Lấy thông tin quản lý
		QuanLy QuanLyKhoiTao = quanLyService.layThongTinTaiKhoan(UIDManager);
		if (QuanLyKhoiTao == null) {
			new Exception("Không tìm thấy thông tin quản lý.").printStackTrace();
			return "components/boardContent/ct-muon-phong-hoc";
		}

		//Tạo dữ liệu và lưu vào hệ thống
		LichMuonPhong CTLichMPH = lichMuonPhongService.luuThongTin(
			new LichMuonPhong(
				lopHocPhanSectionService.layThongTin(Integer.parseInt(IdLHPSection)),
				phongHocService.layThongTin(IdPH),
				QuanLyKhoiTao,
				Converter.stringToDatetime(ThoiGian_BD),
				Converter.stringToDatetime(ThoiGian_KT)));

		if (CTLichMPH == null) {
			redirectAttributes.addFlashAttribute("errorMessage", "Không thể tạo thông tin mượn phòng.");
			return "redirect:/DsMPH/XemDsMPH.htm?UID=" + uid;
		}

		redirectAttributes.addFlashAttribute("errorMessage", "Tạo thông tin thành công");
        return "redirect:../CTMPH/XemTTMPH.htm?UID=" + uid + "&IdLichMPH=" + Integer.parseInt(CTLichMPH.getIdLMPH());
    }
}
