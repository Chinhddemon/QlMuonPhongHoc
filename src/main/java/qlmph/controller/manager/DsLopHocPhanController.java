package qlmph.controller.manager;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import qlmph.model.QLThongTin.NhomHocPhan;
import qlmph.service.NhomHocPhanService;

@Controller
@RequestMapping("/DsLHP")
public class DsLopHocPhanController {

    @Autowired
    NhomHocPhanService nhomHocPhanService;

    @RequestMapping("/XemDsLHP")
    public String showDsLHP(Model model) {

        List<NhomHocPhan> DsLopHocPhan = nhomHocPhanService.layDanhSach();

        // Thiết lập khối dữ liệu hiển thị
        model.addAttribute("DsLopHocPhan", DsLopHocPhan);

        // Thiết lập chuyển hướng trang kế tiếp theo điều kiện Usecase và tương tác View
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

    @RequestMapping("/ThemTTMPH")
    public String showThemTTMPH(Model model) {

        List<NhomHocPhan> DsLopHocPhan = nhomHocPhanService.layDanhSach();

        // Thiết lập khối dữ liệu hiển thị
        model.addAttribute("DsLopHocPhan", DsLopHocPhan);

        // Thiết lập chuyển hướng trang kế tiếp theo điều kiện Usecase và tương tác View
        model.addAttribute("NextUsecaseTableRowChoose", "CTMPH");
        model.addAttribute("NextUsecasePathTableRowChoose", "ThemTTMPH");

        return "components/boardContent/ds-lop-hoc-phan";
    }
}
