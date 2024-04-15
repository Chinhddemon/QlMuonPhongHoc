package qlmph.controller.manager;

import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import qlmph.model.QLTaiKhoan.GiangVien;
import qlmph.model.QLTaiKhoan.QuanLy;
import qlmph.model.QLThongTin.LopSV;
import qlmph.model.QLThongTin.MonHoc;
import qlmph.model.QLThongTin.NhomHocPhan;
import qlmph.service.GiangVienService;
import qlmph.service.LopSVService;
import qlmph.service.MonHocService;
import qlmph.service.NhomHocPhanService;
import qlmph.service.QuanLyService;
import qlmph.utils.ValidateObject;

@Controller
@RequestMapping("/CTLHP")
public class CTLopHocPhan {

	@Autowired
	private ServletContext servletContext;

	@Autowired
	NhomHocPhanService nhomHocPhanService;

	@Autowired
	MonHocService monHocService;

	@Autowired
	LopSVService lopSVService;

	@Autowired
	GiangVienService giangVienService;

	@Autowired
	QuanLyService quanLyService;

	@RequestMapping("XemTTLHP")
	public String showXemTTLHPcreen(Model model,
			RedirectAttributes redirectAttributes,
			@RequestParam("UID") String uid,
			@RequestParam("IdLHP") String IdLHP) {

		// Tạo khối dữ liệu hiển thị
		NhomHocPhan CTLopHocPhan = layThongTinLopHocPhan(IdLHP);
		String IdSection = layIdSection(IdLHP);

		// Kiểm tra dữ liệu lớp học phần
		if (CTLopHocPhan == null) {
			redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy lớp học phần.");
			return "redirect:/CTMPH/XemTTMPH.htm?UID=" + uid + "&IdLHP=" + Integer.parseInt(IdLHP);
		}

		// Thiết lập khối dữ liệu hiển thị
		model.addAttribute("CTLopHocPhan", CTLopHocPhan);
		model.addAttribute("IdSection", IdSection);

		// Thiết lập chuyển hướng trang kế tiếp theo điều kiện Usecase và tương tác View

		return "components/boardContent/ct-lop-hoc-phan";
	}

	@RequestMapping("SuaTTLHP")
	public String showSuaTTLHPScreen(Model model,
			RedirectAttributes redirectAttributes,
			@RequestParam("UID") String uid,
			@RequestParam("IdLHP") String IdLHP) {

		// Lấy thông tin quản lý đang thực hiện
		QuanLy QuanLyKhoiTao = layThongTinQuanLy((String) servletContext.getAttribute("UIDManager"), uid);
		if (QuanLyKhoiTao == null) {
			redirectAttributes.addFlashAttribute("errorMessage", "Không thể lấy thông tin quản lý.");
			return "components/boardContent/ct-muon-phong-hoc";
		}

		// Tạo khối dữ liệu hiển thị
		NhomHocPhan CTLopHocPhan = layThongTinLopHocPhan(IdLHP);
		String IdSection = layIdSection(IdLHP);
		List<MonHoc> DsMonHoc = monHocService.layDanhSach();
		List<LopSV> DsLopSV = lopSVService.layDanhSach();
		List<GiangVien> DsGiangVien = giangVienService.layDanhSach();

		// Kiểm tra dữ liệu lớp học phần
		if (CTLopHocPhan == null) {
			redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy lớp học phần.");
			return "redirect:/CTMPH/XemTTMPH.htm?UID=" + uid + "&IdLHP=" + Integer.parseInt(IdLHP);
		}

		// Thiết lập khối dữ liệu hiển thị
		model.addAttribute("CTLopHocPhan", CTLopHocPhan);
		model.addAttribute("IdSection", IdSection);
		model.addAttribute("DsMonHoc", DsMonHoc);
		model.addAttribute("DsLopSV", DsLopSV);
		model.addAttribute("DsGiangVien", DsGiangVien);

		// Thiết lập chuyển hướng trang kế tiếp
		model.addAttribute("NextUsecaseSubmitOption1", "CTLHP");
		model.addAttribute("NextUsecasePathSubmitOption1", "SuaTTLHP");

		return "components/boardContent/ct-lop-hoc-phan";
	}

	@RequestMapping("ThemTTLHP")
	public String showThemTTLHPScreen(Model model,
			RedirectAttributes redirectAttributes,
			@RequestParam("UID") String uid) {

		// Lấy thông tin quản lý đang thực hiện
		QuanLy QuanLyKhoiTao = layThongTinQuanLy((String) servletContext.getAttribute("UIDManager"), uid);
		if (QuanLyKhoiTao == null) {
			redirectAttributes.addFlashAttribute("errorMessage", "Không thể lấy thông tin quản lý.");
			return "components/boardContent/ct-muon-phong-hoc";
		}

		// Tạo dữ liệu để hiển thị

		// Thiết lập chuyển hướng trang kế tiếp
		model.addAttribute("NextUsecaseSubmitOption2", "CTLHP");
		model.addAttribute("NextUsecasePathSubmitOption2", "ThemTTLHP");

		return "components/boardContent/ct-lop-hoc-phan";
	}

	@RequestMapping("XoaTTLHP")
	public String showXoaTTLHPScreen(
			@RequestParam("IdLHP") int IdLHP,
			Model model) {
		// Tạo khối dữ liệu hiển thị
		// TTLopHocBean tTLopHoc = TTLopHocService.getIdLHP(IdLHP);
		// // Thiết lập khối dữ liệu hiển thị
		// model.addAttribute("TTLopHoc", tTLopHoc);

		// Thiết lập chuyển hướng trang kế tiếp theo điều kiện Usecase và tương tác View

		return "components/boardContent/ct-lop-hoc-phan";
	}

	private String layIdSection(String IdLHP) {
		if (IdLHP.length() == 12) {
			return IdLHP.substring(6, 12);
		} else {
			return "000000";
		}
	}

	private NhomHocPhan layThongTinLopHocPhan(String IdLHP) {
		if (IdLHP.length() == 12) {
			return nhomHocPhanService.layThongTin(Integer.parseInt(IdLHP.substring(0, 6)));
		} else if (IdLHP.length() == 6) {
			return nhomHocPhanService.layThongTin(Integer.parseInt(IdLHP));
		} else {
			return null;
		}
	}

	private QuanLy layThongTinQuanLy(String UIDManager, String uid) {
		if (ValidateObject.isNullOrEmpty(UIDManager) || !UIDManager.equals(uid)) {
			new Exception("Quản lý chưa đăng nhập.").printStackTrace();
			return null;
		}
		QuanLy QuanLyKhoiTao = quanLyService.layThongTinTaiKhoan(UIDManager);
		if (QuanLyKhoiTao == null) {
			new Exception("Không tìm thấy thông tin quản lý.").printStackTrace();
			return null;
		}
		return QuanLyKhoiTao;
	}
}
