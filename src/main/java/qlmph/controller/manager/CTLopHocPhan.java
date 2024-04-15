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

import qlmph.model.QLTaiKhoan.GiangVien;
import qlmph.model.QLTaiKhoan.QuanLy;
import qlmph.model.QLThongTin.LopHocPhanSection;
import qlmph.model.QLThongTin.LopSV;
import qlmph.model.QLThongTin.MonHoc;
import qlmph.model.QLThongTin.NhomHocPhan;
import qlmph.service.GiangVienService;
import qlmph.service.LopHocPhanSectionService;
import qlmph.service.LopSVService;
import qlmph.service.MonHocService;
import qlmph.service.NhomHocPhanService;
import qlmph.service.QuanLyService;
import qlmph.utils.Converter;
import qlmph.utils.Token;
import qlmph.utils.ValidateObject;

@Controller
@RequestMapping("/CTLHP")
public class CTLopHocPhan {

	@Autowired
	private ServletContext servletContext;

	@Autowired
	NhomHocPhanService nhomHocPhanService;

	@Autowired
	LopHocPhanSectionService lopHocPhanSectionService;

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
			model.addAttribute("errorMessage", "Không tìm thấy lớp học phần.");
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

		// Tạo dữ liệu hiển thị
		NhomHocPhan CTLopHocPhan = layThongTinLopHocPhan(IdLHP);
		String IdSection = layIdSection(IdLHP);
		List<MonHoc> DsMonHoc = monHocService.layDanhSach();
		List<LopSV> DsLopSV = lopSVService.layDanhSach();
		List<GiangVien> DsGiangVien = giangVienService.layDanhSach();

		// Kiểm tra dữ liệu lớp học phần
		if (CTLopHocPhan == null) {
			redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy lớp học phần.");
			return "redirect:/CTMPH/XemTTMPH.htm?UID=" + uid + "&IdLHP=" + IdLHP;
		}

		// Thiết lập dữ liệu hiển thị
		model.addAttribute("CTLopHocPhan", CTLopHocPhan);
		model.addAttribute("IdSection", IdSection);
		model.addAttribute("DsMonHoc", DsMonHoc);
		model.addAttribute("DsLopSV", DsLopSV);
		model.addAttribute("DsGiangVien", DsGiangVien);

		// Thiết lập chuyển hướng trang kế tiếp
		model.addAttribute("NextUsecaseSubmitOption2", "CTLHP");
		model.addAttribute("NextUsecasePathSubmitOption2", "SuaTTLHP");

		return "components/boardContent/ct-lop-hoc-phan";
	}

	@RequestMapping(value = "SuaTTLHP", method = RequestMethod.POST)
	public String submitSuaTTLHP(Model model,
			RedirectAttributes redirectAttributes,
			@RequestParam("UID") String uid,
			@RequestParam("XacNhan") String XacNhan,
			@RequestParam("IdLHP") String IdLHP,
			@RequestParam("MaMH") String MaMH,
			@RequestParam("Nhom") String Nhom,
			@RequestParam("To") String To,
			@RequestParam("MaLopSV") String MaLopSV,
			@RequestParam("MaGV-Root") String MaGVRoot,
			@RequestParam("MucDich-Root") String MucDichRoot,
			@RequestParam("Ngay_BD-Root") String Ngay_BDRoot,
			@RequestParam("Ngay_KT-Root") String Ngay_KTRoot,
			@RequestParam(value = "MaGV-Section", required = false) String MaGVSection,
			@RequestParam(value = "MucDich-Section", required = false) String MucDichSection,
			@RequestParam(value = "Ngay_BD-Section", required = false) String Ngay_BDSection,
			@RequestParam(value = "Ngay_KT-Section", required = false) String Ngay_KTSection) {

		// Kiểm tra mã xác nhận
		if (!xacNhanToken((String) servletContext.getAttribute("token"))) {
			redirectAttributes.addFlashAttribute("errorMessage", "Mã xác nhận không hợp lệ.");
			return "redirect:/CTLHP/XemTTLHP.htm?UID=" + uid + "&IdLHP=" + IdLHP;
		}

		// Lấy và kiểm tra thông tin quản lý đang thực hiện
		QuanLy QuanLyKhoiTao = layThongTinQuanLy((String) servletContext.getAttribute("UIDManager"), uid);
		if (QuanLyKhoiTao == null) {
			redirectAttributes.addFlashAttribute("errorMessage", "Không thể lấy thông tin quản lý.");
			return "redirect:/CTLHP/XemTTLHP.htm?UID=" + uid + "&IdLHP=" + IdLHP;
		}

		// Lấy và kiểm tra phần thông tin chính của lớp học phần
		NhomHocPhan CTLopHocPhan = layThongTinLopHocPhan(IdLHP);
		if (CTLopHocPhan == null) {
			System.out.println("CTLopHocPhan null");
			redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy thông tin lớp học phần.");
			return "redirect:/CTLHP/XemTTLHP.htm?UID=" + uid + "&IdLHP=" + IdLHP;
		}

		// Lấy và kiểm tra thông tin phần thứ nhất của lớp học phần
		LopHocPhanSection FirstSection = null;
		for (LopHocPhanSection section : CTLopHocPhan.getLopHocPhanSections()) {
			if (section.getNhomTo() == 255) {
				FirstSection = lopHocPhanSectionService.layThongTin(Integer.parseInt(section.getIdLHPSection()));
				break;
			}
		}
		if (FirstSection == null) {
			System.out.println("FirstSection null");
			redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy thông tin lớp học phần.");
			return "redirect:/CTLHP/XemTTLHP.htm?UID=" + uid + "&IdLHP=" + IdLHP;
		}

		// Lấy và kiểm tra thông tin phần thứ hai của lớp học phần
		LopHocPhanSection SecondSection = null;
		if (!layIdSection(IdLHP).equals("000000")) {
			SecondSection = lopHocPhanSectionService.layThongTin(Integer.parseInt(layIdSection(IdLHP)));
			if (SecondSection == null) {
				System.out.println("SecondSection null" + layIdSection(IdLHP));
				redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy thông tin lớp học phần.");
				return "redirect:/CTLHP/XemTTLHP.htm?UID=" + uid + "&IdLHP=" + IdLHP;
			}
		}

		// Cập nhật thông tin phần thứ nhất và phần thứ hai của lớp học phần
		FirstSection.setGiangVien(giangVienService.layThongTin(MaGVRoot));
		FirstSection.setMucDich(MucDichRoot);
		FirstSection.setNgay_BD(Converter.stringToDate(Ngay_BDRoot));
		FirstSection.setNgay_KT(Converter.stringToDate(Ngay_KTRoot));
		if (SecondSection != null) {
			if (MaGVSection == null || MucDichSection == null || Ngay_BDSection == null || Ngay_KTSection == null) {
				redirectAttributes.addFlashAttribute("errorMessage",
						"Thông tin không hợp lệ, vui lòng nhập đầy đủ thông tin.");
				return "redirect:/CTLHP/XemTTLHP.htm?UID=" + uid + "&IdLHP=" + IdLHP;
			}
			SecondSection.setGiangVien(giangVienService.layThongTin(MaGVSection));
			SecondSection.setMucDich(MucDichSection);
			SecondSection.setNgay_BD(Converter.stringToDate(Ngay_BDSection));
			SecondSection.setNgay_KT(Converter.stringToDate(Ngay_KTSection));
		}

		// Cập nhật phần thông tin chính của lớp học phần
		CTLopHocPhan.setMonHoc(monHocService.layThongTin(MaMH));
		CTLopHocPhan.setNhom(Byte.parseByte(Nhom));
		CTLopHocPhan.setQuanLyKhoiTao(QuanLyKhoiTao);

		// Lần lượt tạo dữ liệu, lưu vào hệ thống và kiểm tra kết quả
		if (!lopHocPhanSectionService.capNhatThongTin(FirstSection)) {
			System.out.println("FirstSection failed");
			redirectAttributes.addFlashAttribute("errorMessage", "Không thể cập nhật thông tin lớp học phần.");
			return "redirect:/CTLHP/XemTTLHP.htm?UID=" + uid + "&IdLHP=" + IdLHP;
		}
		if (SecondSection != null && !lopHocPhanSectionService.capNhatThongTin(SecondSection)) {
			System.out.println("SecondSection failed");
			redirectAttributes.addFlashAttribute("errorMessage", "Không thể cập nhật thông tin lớp học phần.");
			return "redirect:/CTLHP/XemTTLHP.htm?UID=" + uid + "&IdLHP=" + IdLHP;
		}
		if (!nhomHocPhanService.capNhatThongTin(CTLopHocPhan)) {
			System.out.println("CTLopHocPhan failed");
			redirectAttributes.addFlashAttribute("errorMessage", "Không thể cập nhật thông tin lớp học phần.");
			return "redirect:/CTLHP/XemTTLHP.htm?UID=" + uid + "&IdLHP=" + IdLHP;
		}

		redirectAttributes.addFlashAttribute("errorMessage", "Tạo thông tin thành công");
		return "redirect:/CTLHP/XemTTLHP.htm?UID=" + uid + "&IdLHP=" + IdLHP;
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

		// Tạo dữ liệu hiển thị
		List<MonHoc> DsMonHoc = monHocService.layDanhSach();
		List<LopSV> DsLopSV = lopSVService.layDanhSach();
		List<GiangVien> DsGiangVien = giangVienService.layDanhSach();

		// Thiết lập dữ liệu hiển thị
		model.addAttribute("DsMonHoc", DsMonHoc);
		model.addAttribute("DsLopSV", DsLopSV);
		model.addAttribute("DsGiangVien", DsGiangVien);

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

	private boolean xacNhanToken(String token) {
		if (ValidateObject.isNullOrEmpty(token)) {
			return false;
		}
		// Tạo mã xác nhận mới khi xác nhận thành công
		servletContext.setAttribute("token", Token.createRandom());
		return true;
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
