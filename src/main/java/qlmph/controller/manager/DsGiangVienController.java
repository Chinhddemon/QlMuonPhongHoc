package qlmph.controller.manager;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import qlmph.model.QLTaiKhoan.GiangVien;
import qlmph.service.GiangVienService;

import java.util.List;

@Controller
@RequestMapping("/DsGV")
public class DsGiangVienController {

    @Autowired
    GiangVienService giangvienService;

    @RequestMapping("/XemDsGV")
    public String showDsGV(Model model) {
		// Lấy danh sách giảng viên từ service
		List<GiangVien> dsGiangVien = giangvienService.getAll();

		// Thiết lập khối dữ liệu hiển thị cho view
		model.addAttribute("DsGiangVien", dsGiangVien);
		// Thiết lập chuyển hướng trang kế tiếp theo điều kiện Usecase và tương tác View
		model.addAttribute("NextUsecaseTable", "DsMPH");
		model.addAttribute("NextUsecasePathTable", "XemDsMPH");

		// Thiết lập chuyển hướng trang tới ds-giang-vien.jsp
		return "components/boardContent/ds-giang-vien";
    }
}