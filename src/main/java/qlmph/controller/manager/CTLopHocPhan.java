package qlmph.controller.manager;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import qlmph.model.QLThongTin.NhomHocPhan;
import qlmph.service.NhomHocPhanService;

@Controller
@RequestMapping("/CTLHP")
public class CTLopHocPhan {

	@Autowired
	NhomHocPhanService nhomHocPhanService;

	@RequestMapping("XemCTLHP")
	public String showXemCTLHPScreen(Model model,
			RedirectAttributes redirectAttributes,
			@RequestParam("UID") String uid,
			@RequestParam("IdLHP") String IdLHP) {

		// Tạo khối dữ liệu hiển thị
		NhomHocPhan CTLopHocPhan = layThongTinLopHocPhan(IdLHP);
		String IdSection = layIdSection(IdLHP);

		// Kiểm tra dữ liệu lớp học phần
		if(CTLopHocPhan == null) {
			redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy lớp học phần.");
			return "redirect:/CTMPH/XemTTMPH.htm?UID=" + uid + "&IdLHP=" + Integer.parseInt(IdLHP);
		}

		// Thiết lập khối dữ liệu hiển thị
		model.addAttribute("CTLopHocPhan", CTLopHocPhan);
		model.addAttribute("IdSection", IdSection);

		// Thiết lập chuyển hướng trang kế tiếp theo điều kiện Usecase và tương tác View

		return "components/boardContent/ct-lop-hoc-phan";
	}

	@RequestMapping("SuaCTLHP")
	public String showSuaCTLHPScreen(
			@RequestParam("IdLHP") int IdLHP,
			Model model) {
		// Tạo khối dữ liệu hiển thị
		// TTLopHocBean tTLopHoc = TTLopHocService.getIdLHP(IdLHP);
		// // Thiết lập khối dữ liệu hiển thị
		// model.addAttribute("TTLopHoc", tTLopHoc);

		// Thiết lập chuyển hướng trang kế tiếp theo điều kiện Usecase và tương tác View

		return "components/boardContent/ct-lop-hoc-phan";
	}

	@RequestMapping("XoaCTLHP")
	public String showXoaCTLHPScreen(
			@RequestParam("IdLHP") int IdLHP,
			Model model) {
		// Tạo khối dữ liệu hiển thị
		// TTLopHocBean tTLopHoc = TTLopHocService.getIdLHP(IdLHP);
		// // Thiết lập khối dữ liệu hiển thị
		// model.addAttribute("TTLopHoc", tTLopHoc);

		// Thiết lập chuyển hướng trang kế tiếp theo điều kiện Usecase và tương tác View

		return "components/boardContent/ct-lop-hoc-phan";
	}

	private NhomHocPhan layThongTinLopHocPhan(String IdLHP) {
		if(IdLHP.length() == 12) {
			return nhomHocPhanService.layThongTin(Integer.parseInt(IdLHP.substring(0, 6)));
		} else if (IdLHP.length() == 6) {
			return nhomHocPhanService.layThongTin(Integer.parseInt(IdLHP));
		} else {
			return null;
		}
	}

	private String layIdSection (String IdLHP) {
		if(IdLHP.length() == 12) {
			return IdLHP.substring(6, 12);
		} else {
			return "";
		}
	}
}
