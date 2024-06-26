package qlmph.controller.manager;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import qlmph.model.user.GiangVien;
import qlmph.model.user.SinhVien;
import qlmph.service.user.GiangVienService;
import qlmph.service.user.SinhVienService;
import qlmph.utils.ValidateObject;

import java.util.List;

@Controller
@RequestMapping("/DsND")
public class DsNguoiDungController {

    @Autowired
    GiangVienService giangvienService;

    @Autowired
    private SinhVienService sinhVienService;

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
        model.addAttribute("NextUsecasePathTableOption1", "XemTTGV");

        model.addAttribute("NextUsecaseTableOption2", "DsMPH");
        model.addAttribute("NextUsecasePathTableOption2", "XemDsMPH");
        
        model.addAttribute("NextUsecaseTableOption3", "DsMPH");
        model.addAttribute("NextUsecasePathTableOption3", "XemDsMPH");
        model.addAttribute("NextUsecaseTableCommand3", "TheoNgMPH");
        return "components/boardContent/ds-nguoi-dung";
    }

    @RequestMapping("/XemDsSinhVien") // MARK: - XemDsSinhVien
    public String showDsSV(Model model,
            @RequestParam(value = "IdNhomHocPhan", required = false) String IdNhomHocPhan) {

        // Lấy dữ liệu hiển thị
        List<SinhVien> DsSinhVien = null;
        if(IdNhomHocPhan != null) {
            DsSinhVien = sinhVienService.layDanhSachTheoNhomHocPhan(Integer.parseInt(IdNhomHocPhan));
        } else {
            DsSinhVien = sinhVienService.layDanhSach();
        }

        // Kiểm tra dữ liệu hiển thị
        if (ValidateObject.isNullOrEmpty(DsSinhVien)) {
            model.addAttribute("messageStatus", "Có lỗi xảy ra khi tải dữ liệu.");
        }

        // Thiết lập dữ liệu hiển thị
        model.addAttribute("DsSinhVien", DsSinhVien);

        // Thiết lập chuyển hướng trang kế tiếp
        model.addAttribute("NextUsecaseTableOption1", "CTGV");
        model.addAttribute("NextUsecasePathTableOption1", "XemTTGV");

        model.addAttribute("NextUsecaseTableOption2", "DsMPH");
        model.addAttribute("NextUsecasePathTableOption2", "XemDsMPH");
        model.addAttribute("NextUsecaseTableCommand2", "TheoNgMPH");
        
        // model.addAttribute("NextUsecaseTableOption3", "DsMPH");
        // model.addAttribute("NextUsecasePathTableOption3", "XemDsMPH");
        
        return "components/boardContent/ds-nguoi-dung";
    }
}