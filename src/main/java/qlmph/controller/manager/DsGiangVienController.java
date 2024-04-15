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

        // Lấy dữ liệu hiển thị
        List<GiangVien> dsGiangVien = giangvienService.layDanhSach();

        // Kiểm tra dữ liệu hiển thị
        if (dsGiangVien == null) {
            model.addAttribute("errorMessage", "Có lỗi xảy ra khi tải dữ liệu.");
        }

        // Thiết lập dữ liệu hiển thị
        model.addAttribute("DsGiangVien", dsGiangVien);

        // Thiết lập chuyển hướng trang kế tiếp
        model.addAttribute("NextUsecaseTable", "DsMPH");
        model.addAttribute("NextUsecasePathTable", "XemDsMPH");

        return "components/boardContent/ds-giang-vien";
    }
}