package qlmph.controller.manager;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import qlmph.model.GiangVien;
import qlmph.service.GiangVienService;
import qlmph.utils.ValidateObject;

import java.util.List;

@Controller
@RequestMapping("/DsGV")
public class DsGiangVienController {

    @Autowired
    GiangVienService giangvienService;

    @RequestMapping("/XemDsGV") // MARK: - XemDsGV
    public String showDsGV(Model model) {

        // Lấy dữ liệu hiển thị
        List<GiangVien> DsGiangVien = giangvienService.layDanhSach();

        // Kiểm tra dữ liệu hiển thị
        if (ValidateObject.isNullOrEmpty(DsGiangVien)) {
            model.addAttribute("messageStatus", "Có lỗi xảy ra khi tải dữ liệu.");
        }

        // Thiết lập dữ liệu hiển thị
        model.addAttribute("DsGiangVien", DsGiangVien);

        // Thiết lập chuyển hướng trang kế tiếp
        model.addAttribute("NextUsecaseTableOption1", "CTGV");
        model.addAttribute("NextUsecasePathTableOption1", "XemCTGV");

        model.addAttribute("NextUsecaseTableOption2", "DsMPH");
        model.addAttribute("NextUsecasePathTableOption2", "XemDsMPH");
        
        model.addAttribute("NextUsecaseTableOption3", "DsMPH");
        model.addAttribute("NextUsecasePathTableOption3", "XemDsMPH");
        model.addAttribute("NextUsecaseTableCommand3", "TheoNgMPH");
        return "components/boardContent/ds-giang-vien";
    }
}