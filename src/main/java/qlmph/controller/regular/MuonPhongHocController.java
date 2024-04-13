package qlmph.controller.regular;

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

import qlmph.model.QLTaiKhoan.NguoiMuonPhong;
import qlmph.model.QLTaiKhoan.QuanLy;
import qlmph.model.QLThongTin.LichMuonPhong;
import qlmph.model.QLThongTin.MuonPhongHoc;
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
		model.addAttribute("NextUsecaseTableRowChoose", "MPH");
		model.addAttribute("NextUsecasePathTableRowChoose", "MPH");

		return "components/boardContent/ds-lich-muon-phong";
	}

	@RequestMapping("/MPH")
	public String showLoginForm(Model model,
			@RequestParam("IdLichMPH") int IdLichMPH,
			@RequestParam("UID") String uid) {
		// Tạo khối dữ liệu hiển thị
		LichMuonPhong CTLichMPH = lichMuonPhongService.layThongTin(IdLichMPH);
		NguoiMuonPhong NgMuonPhong = nguoiMuonPhongService.layThongTinTaiKhoan(uid);

		// Thiết lập khối dữ liệu hiển thị
		model.addAttribute("CTLichMPH", CTLichMPH);
		model.addAttribute("NgMuonPhong", NgMuonPhong);

		// Thiết lập chuyển hướng trang kế tiếp theo điều kiện Usecase và tương tác View
		model.addAttribute("NextUsecaseSubmitOption2", "MPH");
		model.addAttribute("NextUsecasePathSubmitOption2", "MPH");

		return "components/boardContent/ct-muon-phong-hoc";
	}

	@RequestMapping(value = "/MPH", method = RequestMethod.POST)
	public String submit(Model model,
			RedirectAttributes redirectAttributes,
			@RequestParam("IdLichMPH") int IdLichMPH,
			@RequestParam("UID") String uid,
			@RequestParam("XacNhan") String XacNhan,
			@RequestParam("YeuCau") String YeuCau) {

		// Lấy khối dữ liệu chỉnh sửa
		LichMuonPhong CTLichMPH = lichMuonPhongService.layThongTin(IdLichMPH);
		NguoiMuonPhong NgMuonPhong = nguoiMuonPhongService.layThongTinTaiKhoan(uid);

		String token = (String) servletContext.getAttribute("token");
		if (token == null || token.isEmpty() || !XacNhan.equals(token)) {
			new Exception("Mã xác nhận không đúng.").printStackTrace();
			return "redirect:/MPH/MPH.htm";
		}

		String UIDManager = (String) servletContext.getAttribute("UIDManager");
		if (UIDManager == null || UIDManager.isEmpty()) {
			new Exception("Quản lý chưa đăng nhập.").printStackTrace();
			return "login";
		}

		QuanLy QuanLyDuyet = quanLyService.layThongTinTaiKhoan(UIDManager);
		if (QuanLyDuyet == null) {
			new Exception("Không tìm thấy thông tin quản lý.").printStackTrace();
			return "login";
		}
		// Tạo khối dữ liệu và lưu vào hệ thống
		MuonPhongHoc muonPhongHoc = muonPhongHocService.luuThongTin(
			new MuonPhongHoc(
				Integer.parseInt(CTLichMPH.getIdLMPH()),
				NgMuonPhong,
				QuanLyDuyet,
				new Date(),
				null,
				YeuCau));

		if (muonPhongHoc == null) {
			redirectAttributes.addFlashAttribute("errorMessage", "Không thể tạo thông tin mượn phòng, liên hệ với quản lý để được hỗ trợ.");
			return "redirect:/MPH/MPH.htm?IdLichMPH=" + IdLichMPH + "&UID=" + uid;
		}

		redirectAttributes.addFlashAttribute("errorMessage", "Tạo thông tin thành công");
		return "redirect:../Introduce.htm";
	}
}