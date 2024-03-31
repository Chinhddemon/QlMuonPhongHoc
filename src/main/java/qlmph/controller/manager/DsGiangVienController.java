package qlmph.controller.manager;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import qlmph.model.QLTaiKhoan.GiangVien;
import qlmph.service.GiangVienService;

// @Controller
// @RequestMapping("/DsGV")
// public class DsGiangVienController {
// 	private final GiangVienService giangVienService;
	
// 	@Autowired
//     public DsGiangVien(GiangVienService giangVienService) {
//         this.giangVienService = giangVienService;
//     }
    
//     @RequestMapping("/XemDsGV")
//     public String showDsGV(Model model) {
//     	// Lấy mọi thông tin trong database bảng giảng viên
//     	// List<GiangVien> dsGiangVien = giangVienService.getAll();
// 		List<GiangVien> dsGiangVien = new ArrayList<>();

// 		dsGiangVien.add(giangVienService.getByIdGV("N21DCCN011"));
    	
//     	// Thiết lập khối dữ liệu hiển thị
// 		model.addAttribute("DsGiangVien", dsGiangVien);
		
// 		// Thiết lập chuyển hướng trang kế tiếp theo điều kiện Usecase và tương tác View
// 		model.addAttribute("NextUsecaseTable", "DsMPH");
// 		model.addAttribute("NextUsecasePathTable", "XemDsMPH");
		
//     	return "components/boardContent/ds-giang-vien";
//     }
// }