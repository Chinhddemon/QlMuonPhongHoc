package qlmph.controller.manager;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import qlmph.model.NhomHocPhan;
import qlmph.service.NhomHocPhanService;
import qlmph.utils.ValidateObject;

@Controller
@RequestMapping("/DsLHP")
public class DsLopHocPhanController {

    @Autowired
    NhomHocPhanService nhomHocPhanService;

    @RequestMapping("/XemDsLHP") // MARK: - XemDsLHP
    public String showDsLHP(Model model) {

        // Lấy dữ liệu hiển thị
        List<NhomHocPhan> DsLopHocPhan = nhomHocPhanService.layDanhSach();

        // Kiểm tra dữ liệu hiển thị
        if (ValidateObject.isNullOrEmpty(DsLopHocPhan)) {
            model.addAttribute("errorMessage", "Có lỗi xảy ra khi tải dữ liệu.");
        }

        // Thiết lập dữ liệu hiển thị
        model.addAttribute("DsLopHocPhan", DsLopHocPhan);

        // Thiết lập chuyển hướng trang kế tiếp
        model.addAttribute("NextUsecaseTableOption1", "CTLHP");
        model.addAttribute("NextUsecasePathTableOption1", "XemTTLHP");

        model.addAttribute("NextUsecaseTableOption2", "CTLHP");
        model.addAttribute("NextUsecasePathTableOption2", "SuaTTLHP");

        model.addAttribute("NextUsecaseTableOption3", "CTLHP");
        model.addAttribute("NextUsecasePathTableOption3", "XoaTTLHP");

        model.addAttribute("NextUsecaseTableOption4", "DsMPH");
        model.addAttribute("NextUsecasePathTableOption4", "XemDsMPH");

        return "components/boardContent/ds-lop-hoc-phan";
    }

    @RequestMapping("/ThemTTMPH") // MARK: - ThemTTMPH
    public String showThemTTMPH(Model model) {

        // Lấy dữ liệu hiển thị
        List<NhomHocPhan> DsLopHocPhan = nhomHocPhanService.layDanhSach();

        // Thiết lập dữ liệu hiển thị
        model.addAttribute("DsLopHocPhan", DsLopHocPhan);

        // Thiết lập chuyển hướng trang kế tiếp
        model.addAttribute("NextUsecaseTableRowChoose", "CTMPH");
        model.addAttribute("NextUsecasePathTableRowChoose", "ThemTTMPH");

        return "components/boardContent/ds-lop-hoc-phan";
    }
}
