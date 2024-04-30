package qlmph.controller.manager;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import qlmph.model.GiangVien;
import qlmph.model.SinhVien;
import qlmph.service.GiangVienService;
import qlmph.service.SinhVienService;
import qlmph.utils.ValidateObject;

@Controller
@RequestMapping("/DsNgMPH")
public class DsNguoiMuonPhongController {

    @Autowired
    private GiangVienService giangvienService;

    @Autowired
    private SinhVienService sinhVienService;

    @RequestMapping("/XemDsNgMPH") // MARK: - DsNgMPH
    public String showLoginForm(Model model) {

        // Lấy dữ liệu hiển thị
        List<GiangVien> DsGiangVien = giangvienService.layDanhSach();
        List<SinhVien> DsSinhVien = sinhVienService.layDanhSach();

        // Kiểm tra dữ liệu hiển thị
        if (ValidateObject.exsistNullOrEmpty(DsGiangVien, DsSinhVien)) {
            model.addAttribute("messageStatus", "Có lỗi xảy ra khi tải dữ liệu.");
        }

        // Thiết lập dữ liệu hiển thị
        model.addAttribute("DsGiangVien", DsGiangVien);
        model.addAttribute("DsSinhVien", DsSinhVien);

        // Thiết lập chuyển hướng trang kế tiếp
        // model.addAttribute("NextUsecaseTableOption1", "CTGV");
        // model.addAttribute("NextUsecasePathTableOption1", "XemCTGV");

        // model.addAttribute("NextUsecaseTableOption2", "DsMPH");
        // model.addAttribute("NextUsecasePathTableOption2", "XemDsMPH");
        
        // model.addAttribute("NextUsecaseTableOption3", "DsMPH");
        // model.addAttribute("NextUsecasePathTableOption3", "XemDsMPH");
        // model.addAttribute("NextUsecaseTableCommand3", "TheoNgMPH");

        return "components/boardContent/ds-nguoi-dung";
    }

}