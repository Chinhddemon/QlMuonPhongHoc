package qlmph.controller.manager;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.ServletContext;
import qlmph.model.universityCourse.NhomHocPhan;
import qlmph.model.user.QuanLy;
import qlmph.service.universityCourse.NhomHocPhanService;
import qlmph.service.user.QuanLyService;
import qlmph.utils.ValidateObject;

@Controller
@RequestMapping("/DsNhomHocPhan")
public class DsNhomHocPhanController {

    @Autowired
    private ServletContext servletContext;

    @Autowired
    private NhomHocPhanService nhomHocPhanService;

    @Autowired
    private QuanLyService quanLyService;

    @RequestMapping("/XemDsNhomHocPhan") // MARK: - XemDsNhomHocPhan
    public String showDsNhomHocPhan(Model model,
            RedirectAttributes redirectAttributes,
            @RequestParam("UID") String uid) {

        // Lấy và kiểm tra thông tin quản lý đang trực
        QuanLy QuanLyKhoiTao = quanLyService.layThongTinQuanLyDangTruc((String) servletContext.getAttribute("UIDManager"), uid);
        if (ValidateObject.isNullOrEmpty(QuanLyKhoiTao)) {
            redirectAttributes.addFlashAttribute("messageStatus", "Không thể tìm thấy thông tin quản lý.");
            return "redirect:../Introduce";
        }

        // Lấy dữ liệu hiển thị
        List<NhomHocPhan> DsNhomHocPhan = nhomHocPhanService.layDanhSach();

        // Kiểm tra dữ liệu hiển thị
        if (ValidateObject.isNullOrEmpty(DsNhomHocPhan)) {
            model.addAttribute("messageStatus", "Có lỗi xảy ra khi tải dữ liệu.");
        }

        // Thiết lập dữ liệu hiển thị
        model.addAttribute("DsNhomHocPhan", DsNhomHocPhan);
        // model.addAttribute("CurrentDateTime", new Date());

        // Thiết lập chuyển hướng trang kế tiếp
        model.addAttribute("NextUsecaseNavOption1", "DsHocPhan");
        model.addAttribute("NextUsecasePathNavOption1", "XemDsHocPhan");

        model.addAttribute("NextUsecaseTableOption1", "CTHocPhan");
        model.addAttribute("NextUsecasePathTableOption1", "XemTTHocPhan");

        model.addAttribute("NextUsecaseTableOption2", "CTHocPhan");
        model.addAttribute("NextUsecasePathTableOption2", "SuaTTHocPhan");

        model.addAttribute("NextUsecaseTableOption3", "CTHocPhan");
        model.addAttribute("NextUsecasePathTableOption3", "XoaTTHocPhan");

        model.addAttribute("NextUsecaseTableOption4", "DsMPH");
        model.addAttribute("NextUsecasePathTableOption4", "XemDsMPH");

        return "components/boardContent/ds-nhom-hoc-phan";
    }

    @RequestMapping("/ThemTTMPH") // MARK: - ThemTTMPH
    public String showThemTTMPH(Model model) {

        // Lấy dữ liệu hiển thị
        List<NhomHocPhan> DsNhomHocPhan = nhomHocPhanService.layDanhSach();

        if (ValidateObject.isNullOrEmpty(DsNhomHocPhan)) {
            model.addAttribute("messageStatus", "Có lỗi xảy ra khi tải dữ liệu.");
        }

        // Thiết lập dữ liệu hiển thị
        model.addAttribute("DsNhomHocPhan", DsNhomHocPhan);

        // Thiết lập chuyển hướng trang kế tiếp
        model.addAttribute("NextUsecaseNavOption1", "DsHocPhan");
        model.addAttribute("NextUsecasePathNavOption1", "ThemTTMPH");

        model.addAttribute("NextUsecaseTableRowChoose", "CTMPH");
        model.addAttribute("NextUsecasePathTableRowChoose", "ThemTTMPH");

        return "components/boardContent/ds-nhom-hoc-phan";
    }
}
