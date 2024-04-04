package qlmph.controller.manager;

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
import qlmph.service.LopHocPhanService;
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
    LopHocPhanService lopHocPhanService;

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
		if(IdLichMPH == 0) {
			new Exception("Không tìm thấy lịch mượn phòng").printStackTrace();
			return "redirect:../Error.htm?Message=IdLichMPH not found 404";
		}

		// Tạo khối dữ liệu hiển thị
		LichMuonPhong CTLichMPH = lichMuonPhongService.layThongTin(IdLichMPH);
				// please optimaze it!!!
		QuanLy QuanLyKhoiTao = quanLyService.layThongTin(CTLichMPH.getMuonPhongHoc().getQuanLyDuyet().getMaQL()());
		NguoiMuonPhong NgMPH = null;
		QuanLy QuanLyDuyet = null;
		if(CTLichMPH.getMuonPhongHoc() != null) {
			NgMPH = nguoiMuonPhongService.layThongTin(CTLichMPH.getMuonPhongHoc().getMaNgMPH());
			// please optimaze it!!!
			QuanLyDuyet = quanLyService.layThongTin(CTLichMPH.getMuonPhongHoc().getQuanLyDuyet().getMaQL());
		}
		
		// Thiết lập khối dữ liệu hiển thị
		model.addAttribute("CTLichMPH", CTLichMPH);
		model.addAttribute("QuanLyKhoiTao", QuanLyKhoiTao);
		model.addAttribute("NgMPH", NgMPH);
		model.addAttribute("QuanLyDuyet", QuanLyDuyet);
		
		// Thiết lập chuyển hướng trang kế tiếp theo điều kiện Usecase và tương tác View
		
        return "components/boardContent/ct-muon-phong-hoc";
    }
    
    @RequestMapping("/SuaTTMPH")
    public String showSuaTTMPHScreen(Model model,
			@RequestParam("UID") String uid,
    		@RequestParam ("IdLichMPH") int IdLichMPH) {

    	// Tạo khối dữ liệu hiển thị
		LichMuonPhong CTLichMPH = lichMuonPhongService.layThongTin(IdLichMPH);
		// please optimaze it!!!
		QuanLy QuanLyKhoiTao = quanLyService.layThongTin(CTLichMPH.getMaQLKhoiTao());
		NguoiMuonPhong NgMPH = null;
		QuanLy QuanLyDuyet = null;
		if(CTLichMPH.getMuonPhongHoc() != null) {
			NgMPH = nguoiMuonPhongService.layThongTin(CTLichMPH.getMuonPhongHoc().getMaNgMPH());
			QuanLyDuyet = quanLyService.layThongTin(CTLichMPH.getMuonPhongHoc().getMaQLDuyet());// please optimaze it!!!
		}
		
		// Thiết lập khối dữ liệu hiển thị
		model.addAttribute("CTLichMPH", CTLichMPH);
		model.addAttribute("QuanLyKhoiTao", QuanLyKhoiTao);
		model.addAttribute("NgMPH", NgMPH);
		model.addAttribute("QuanLyDuyet", QuanLyDuyet);
		
		// Thiết lập chuyển hướng trang kế tiếp theo điều kiện Usecase và tương tác View
		
        return "components/boardContent/ct-muon-phong-hoc";
    }
    
    @RequestMapping("/ThemTTMPH")
    public String showThemTTMPHScreen(Model model,
			@RequestParam("UID") String uid) {
		
		// Lấy khối dữ liệu chỉnh sửa	
		String UIDManager = (String) servletContext.getAttribute("UIDManager");
		if (UIDManager == null || UIDManager.isEmpty()) {
			new Exception("Quản lý chưa đăng nhập.").printStackTrace();
			return "login";
		} else if (!UIDManager.equals(uid)) {
			new Exception("Quản lý đăng nhập không khớp với hệ thống.").printStackTrace();
			return "login";
		}

		QuanLy QuanLyKhoiTao = quanLyService.layThongTinTaiKhoan(UIDManager);
		if (QuanLyKhoiTao == null) {
			new Exception("Không tìm thấy thông tin quản lý.").printStackTrace();
			return "login";
		}

		// Thiết lập khối dữ liệu hiển thị
		model.addAttribute("QuanLyKhoiTao", QuanLyKhoiTao);

		// Thiết lập chuyển hướng trang kế tiếp theo điều kiện Usecase và tương tác View
		model.addAttribute("NextUsecaseSubmitOption1", "CTMPH");
		model.addAttribute("NextUsecasePathSubmitOption1", "ThemTTMPH");
		
		return "components/boardContent/ct-muon-phong-hoc";
    }

	@RequestMapping(value = "/ThemTTMPH", method = RequestMethod.POST)
    public String submit(Model model,
			@RequestParam("UID") String uid,
			@RequestParam("XacNhan") String XacNhan,
			@RequestParam("IdLHP") int IdLHP,
			@RequestParam("MaPH") String MaPH,
			@RequestParam("ThoiGian_BD") String ThoiGian_BD,
			@RequestParam("ThoiGian_KT") String ThoiGian_KT,
			@RequestParam("MucDich") String MucDich,
			@RequestParam(value = "LyDo", required = false, defaultValue = "") String LyDo) {

		// Lấy khối dữ liệu chỉnh sửa	
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
		LichMuonPhong test = new LichMuonPhong();
		System.out.println(test);

		//Tạo khối dữ liệu và lưu vào hệ thống
		LichMuonPhong CTLichMPH = lichMuonPhongService.luuThongTin(
			new LichMuonPhong(
				phongHocService.layThongTin(MaPH),
				lopHocPhanService.layThongTin(IdLHP),
				QuanLyKhoiTao.getMaQL(),
				ThoiGian_BD,
				ThoiGian_KT,
				MucDich,
				LyDo));
		System.out.println(CTLichMPH);
		if (CTLichMPH == null) {
			new Exception("Không thể tạo thông tin").printStackTrace();
			return "redirect:/MPH/MPH.htm";
		}

		System.out.println("Tạo thông tin thành công.");

		int IdLichMPH = CTLichMPH.getIdLMPH();

        return "redirect:../CTMPH/XemTTMPH.htm?UID=" + uid + "&IdLichMPH=" + IdLichMPH;
    }
    
}
