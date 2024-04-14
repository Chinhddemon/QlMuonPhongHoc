package qlmph.controller.manager;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import qlmph.model.QLThongTin.NhomHocPhan;
import qlmph.service.NhomHocPhanService;

@Controller
@RequestMapping("/CTLHP")
public class CTLopHocPhan {

	@Autowired
	NhomHocPhanService nhomHocPhanService;

	@RequestMapping("XemCTLHP")
	public String showXemCTLHPScreen(
			@RequestParam("IdLHP") int IdLHP,
			Model model) {

		// Tạo khối dữ liệu hiển thị
		NhomHocPhan CTLopHocPhan = nhomHocPhanService.layThongTin(IdLHP);

		// Thiết lập khối dữ liệu hiển thị
		model.addAttribute("CTLopHocPhan", CTLopHocPhan);

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
}
