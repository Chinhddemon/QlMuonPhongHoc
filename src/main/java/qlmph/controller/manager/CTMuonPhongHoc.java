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
import qlmph.service.PhongHocService;
import qlmph.service.QuanLyService;
import qlmph.utils.Converter;
import qlmph.utils.Token;
import qlmph.utils.ValidateObject;

@Controller
@RequestMapping("/CTMPH")
public class CTMuonPhongHoc {

	@Autowired
	private ServletContext servletContext;

	@Autowired
	private LichMuonPhongService lichMuonPhongService;

	@Autowired
	private LopHocPhanSectionService lopHocPhanSectionService;

	@Autowired
	private QuanLyService quanLyService;

	@Autowired
	private PhongHocService phongHocService;

	@RequestMapping("/XemTTMPH")
	public String showTTMPHScreen(Model model,
			@RequestParam("UID") String uid,
			@RequestParam("IdLichMPH") String IdLichMPH) {

		// Tạo khối dữ liệu hiển thị
		LichMuonPhong CTLichMPH = lichMuonPhongService.layThongTin(Integer.parseInt(IdLichMPH));

		// Thiết lập khối dữ liệu hiển thị
		model.addAttribute("CTLichMPH", CTLichMPH);

		// Thiết lập chuyển hướng trang kế tiếp

		return "components/boardContent/ct-muon-phong-hoc";
	}

	@RequestMapping("/SuaTTMPH")
	public String showSuaTTMPHScreen(Model model,
			@RequestParam("UID") String uid,
			@RequestParam("IdLichMPH") int IdLichMPH) {

		// Tạo dữ liệu hiển thị
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
		if (!xacNhanToken((String) servletContext.getAttribute("token"))) {
			redirectAttributes.addFlashAttribute("errorMessage", "Mã xác nhận không đúng.");
			return "redirect:/DsMPH/XemDsMPH.htm?UID=" + uid;
		}

		// Lấy thông tin quản lý đang thực hiện
		QuanLy QuanLyKhoiTao = layThongTinQuanLy((String) servletContext.getAttribute("UIDManager"), uid);
		
		// Lấy thông tin lịch mượn phòng
		LichMuonPhong CTLichMPH = lichMuonPhongService.layThongTin(Integer.parseInt(IdLichMPH));

		// Kiểm tra giữa thông tin lịch mượn phòng
		if(CTLichMPH == null) {
			redirectAttributes.addFlashAttribute("errorMessage", "Không thể lấy thông tin lịch mượn phòng.");
			return "redirect:/DsMPH/XemDsMPH.htm?UID=" + uid;
		}

		// Kiểm tra thông tin quản lý
		if (QuanLyKhoiTao == null) {
			redirectAttributes.addFlashAttribute("errorMessage", "Không thể lấy thông tin quản lý.");
			return "components/boardContent/ct-muon-phong-hoc";
		}

		// Cập nhật thông tin lịch mượn phòng
		CTLichMPH.setPhongHoc(phongHocService.layThongTin(IdPH));
		CTLichMPH.setQuanLyKhoiTao(QuanLyKhoiTao);
		CTLichMPH.setThoiGian_BD(Converter.stringToDatetime(ThoiGian_BD));
		CTLichMPH.setThoiGian_KT(Converter.stringToDatetime(ThoiGian_KT));
		CTLichMPH.setLyDo(LyDo);

		// Tạo dữ liệu, lưu vào hệ thống và kiểm tra kết quả
		if (!lichMuonPhongService.capNhatThongTin(CTLichMPH)) {
			redirectAttributes.addFlashAttribute("errorMessage", "Không thể tạo thông tin mượn phòng.");
			return "redirect:/CTMPH/XemTTMPH.htm?UID=" + uid + "&IdLichMPH=" + IdLichMPH;
		}

		redirectAttributes.addFlashAttribute("errorMessage", "Tạo thông tin thành công");
		return "redirect:../CTMPH/XemTTMPH.htm?UID=" + uid + "&IdLichMPH=" + IdLichMPH;
	}

	@RequestMapping("/ThemTTMPH")
	public String showThemTTMPHScreen(Model model,
			RedirectAttributes redirectAttributes,
			@RequestParam("UID") String uid,
			@RequestParam("IdLHP") int IdLHP) {

		// Lấy thông tin quản lý đang thực hiện
		QuanLy QuanLyKhoiTao = layThongTinQuanLy((String) servletContext.getAttribute("UIDManager"), uid);
		if (QuanLyKhoiTao == null) {
			redirectAttributes.addFlashAttribute("errorMessage", "Không thể lấy thông tin quản lý.");
			return "components/boardContent/ct-muon-phong-hoc";
		}

		// Tạo dữ liệu để hiển thị
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
			@RequestParam("ThoiGian_KT") String ThoiGian_KT) {

		// Kiểm tra mã xác nhận
		if (!xacNhanToken((String) servletContext.getAttribute("token"))) {
			redirectAttributes.addFlashAttribute("errorMessage", "Mã xác nhận không đúng.");
			return "redirect:/DsMPH/XemDsMPH.htm?UID=" + uid;
		}

		// Lấy thông tin quản lý đang thực hiện
		QuanLy QuanLyKhoiTao = layThongTinQuanLy((String) servletContext.getAttribute("UIDManager"), uid);
		
		// Kiểm tra thông tin quản lý
		if (QuanLyKhoiTao == null) {
			redirectAttributes.addFlashAttribute("errorMessage", "Không thể lấy thông tin quản lý.");
			return "redirect:/DsMPH/XemDsMPH.htm?UID=" + uid;
		}

		// Tạo dữ liệu và lưu vào hệ thống
		LichMuonPhong CTLichMPH = lichMuonPhongService.luuThongTin(
				new LichMuonPhong(
						lopHocPhanSectionService.layThongTin(Integer.parseInt(IdLHPSection)),
						phongHocService.layThongTin(IdPH),
						QuanLyKhoiTao,
						Converter.stringToDatetime(ThoiGian_BD),
						Converter.stringToDatetime(ThoiGian_KT)));

		// Kiểm tra kết quả
		if (CTLichMPH == null) {
			redirectAttributes.addFlashAttribute("errorMessage", "Không thể tạo thông tin mượn phòng.");
			return "redirect:/DsMPH/XemDsMPH.htm?UID=" + uid;
		}

		redirectAttributes.addFlashAttribute("errorMessage", "Tạo thông tin thành công");
		return "redirect:../CTMPH/XemTTMPH.htm?UID=" + uid + "&IdLichMPH=" + CTLichMPH.getIdLMPH();
	}

	@RequestMapping("/TraTTMPH")
	public String showTraTTMPHScreen(Model model,
			@RequestParam("UID") String uid,
			@RequestParam("IdLichMPH") int IdLichMPH) {

		// Tạo khối dữ liệu hiển thị
		LichMuonPhong CTLichMPH = lichMuonPhongService.layThongTin(IdLichMPH);

		// Thiết lập khối dữ liệu hiển thị
		model.addAttribute("CTLichMPH", CTLichMPH);

		// Thiết lập chuyển hướng trang kế tiếp
		model.addAttribute("NextUsecaseSubmitOption1", "CTMPH");
		model.addAttribute("NextUsecasePathSubmitOption1", "TraTTMPH");

		return "components/boardContent/ct-muon-phong-hoc";
	}

	@RequestMapping(value = "/TraTTMPH", method = RequestMethod.POST)
	public String submitTraTTMPH(Model model,
			RedirectAttributes redirectAttributes,
			@RequestParam("UID") String uid,
			@RequestParam("XacNhan") String XacNhan,
			@RequestParam("IdLichMPH") String IdLichMPH) {

		// Kiểm tra mã xác nhận
		if (!xacNhanToken((String) servletContext.getAttribute("token"))) {
			redirectAttributes.addFlashAttribute("errorMessage", "Mã xác nhận không đúng.");
			return "redirect:/CTMPH/XemTTMPH.htm?UID=" + uid + "&IdLichMPH=" + IdLichMPH;
		}

		// Lấy thông tin quản lý đang thực hiện
		QuanLy QuanLyKhoiTao = layThongTinQuanLy((String) servletContext.getAttribute("UIDManager"), uid);
		if (QuanLyKhoiTao == null) {
			redirectAttributes.addFlashAttribute("errorMessage", "Không thể lấy thông tin quản lý.");
			return "redirect:/CTMPH/XemTTMPH.htm?UID=" + uid + "&IdLichMPH=" + IdLichMPH;
		}

		// Lấy thông tin lịch mượn phòng
		LichMuonPhong CTLichMPH = lichMuonPhongService.layThongTin(Integer.parseInt(IdLichMPH));

		// Kiểm tra giữa thông tin lịch mượn phòng và thông tin quản lý
		if (!CTLichMPH.getQuanLyKhoiTao().equals(QuanLyKhoiTao)) {
			redirectAttributes.addFlashAttribute("errorMessage",
					"Không thể xác nhận trả lịch mượn phòng của quản lý khác.");
			return "redirect:/CTMPH/XemTTMPH.htm?UID=" + uid + "&IdLichMPH=" + IdLichMPH;
		}

		// Cập nhật thông tin lịch mượn phòng
		CTLichMPH.getMuonPhongHoc().setThoiGian_TPH(new Date());

		// Tạo dữ liệu, lưu vào hệ thống và kiểm tra kết quả
		if (lichMuonPhongService.capNhatThongTin(CTLichMPH)) {
			redirectAttributes.addFlashAttribute("errorMessage", "Không thể tạo thông tin mượn phòng.");
			return "redirect:/CTMPH/XemTTMPH.htm?UID=" + uid + "&IdLichMPH=" + IdLichMPH;
		}

		redirectAttributes.addFlashAttribute("errorMessage", "Tạo thông tin thành công");
		return "redirect:../CTMPH/XemTTMPH.htm?UID=" + uid + "&IdLichMPH=" + IdLichMPH;
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
			return null;
		}
		QuanLy QuanLyKhoiTao = quanLyService.layThongTinTaiKhoan(UIDManager);
		if (QuanLyKhoiTao == null) {
			return null;
		}
		return QuanLyKhoiTao;
	}
}
